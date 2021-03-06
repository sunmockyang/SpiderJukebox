# MP3Parser.rb
require 'stringio'
require 'net/http'
require 'uri'
require 'mp3info'

class MP3Parser < SpiderParser
	def initialize
	end

	def self.parser_name
		"MP3"
	end

	def self.can_parse?(url)
		return url.end_with? ".mp3"
	end

	def parse(url)
		metadata = {}
		
		buffer = request_range(url, (0..100))
		
		if buffer !~ /^ID3/
			metadata = parse_id3v1(url)
		else
			metadata = parse_id3v2(url)
		end

		track = nil

		if (!metadata.empty?)
			metadata[:source] = MP3Parser.parser_name
			metadata[:url] = url
			track = SpiderTrack.new(metadata)
		end

		return track
	end

	private
		ID3v1tagSize = 128 * 10
		ID3v2tagSize = 6
		ID3v2headerSize = 10

		# Tag at end of file
		def parse_id3v1(url)
			metadata = {}
			file_size = request_file_size(url)

			if file_size > ID3v1tagSize
				range = ((file_size - ID3v1tagSize)..file_size)
				buffer = request_range(url, range)
				metadata = parse_buffer_metadata(buffer, file_size)
			end

			return metadata
		end

		# Tag at start of file
		def parse_id3v2(url)
			tag_size = get_id3v2_tag_size(url)
			file_size = request_file_size(url)
			buffer = request_range(url, (0..tag_size))
			return parse_buffer_metadata(buffer, file_size)
		end

		def get_id3v2_tag_size(url)
			buffer = request_range(url, (0..100))
			return ID3v2headerSize + unmungeSize(buffer[ID3v2tagSize..ID3v2tagSize+4]) + 4
		end

		def unmungeSize(bytes)
			size = 0
			j = 0; i = 3 
			while i >= 0
				size += 128**i * (bytes.getbyte(j) & 0x7f)
				j += 1
				i -= 1
			end
			return size
		end

		def parse_buffer_metadata(buffer, file_size)
			metadata = {}

			Mp3Info.open( StringIO.open(buffer) ) do |mp3|  #do the parsing
				metadata[:title] = mp3.tag.title 
				metadata[:album] = mp3.tag.album 
				metadata[:artist] = mp3.tag.artist

				# don't know how well this will work...
				if file_size > 0
					if !mp3.tag2.empty?
						metadata[:duration_ms] = (file_size - buffer.length) * 8 / mp3.bitrate
					else
						metadata[:duration_ms] = (file_size - ID3v1tagSize) * 8 / mp3.bitrate
					end
				end
			end

			return metadata
		end

		def request_range(url, range)
			begin
				uri = URI(url)
				Net::HTTP.version_1_2 
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = uri.scheme == "https"
				resp = http.get(url, {'Range' => "bytes=#{range.begin}-#{range.end}"} )
				resp_code = resp.code.to_i
				if (resp_code >= 200 && resp_code < 300) then
					return resp.body
				else
					return ''
				end
			rescue
				return ''
			end
		end

		def request_file_size(url)
			begin
				uri = URI(url)
				file_size = 0
				Net::HTTP.start(uri.host, 80) do |http|
					response = http.request_head(url)
					file_size = response['content-length'].to_i
				end
			rescue
				file_size = 0
			end
			return file_size
		end
end
