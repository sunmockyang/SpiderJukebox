# MP3Parser.rb
require 'stringio'
require 'net/http'
require 'uri'
require 'mp3info'

class MP3Parser < SpiderParser

	def initialize(url)
	end

	def self.can_parse?(url)
		return url.end_with? ".mp3"
	end

	def parse(url)
		metadata = parse_id3v2(url)
		if metadata.empty?
			metadata = parse_id3v1(url)
		end

		metadata[:source] = parser_name
		metadata[:url] = url

		return SpiderTrack.new(metadata)
	end

	private
		@@ID3V1_TAG_SIZE = 128
		@@ID3V2_TAG_SIZE = 256000 # arbitrary length

		# Tag at start of file
		def parse_id3v2(url)
			return range_request_metadata(url, (0..@@ID3V2_TAG_SIZE))
		end

		# Tag at end of file
		def parse_id3v1(url)
			# Haven't found a way to parse partial files for id3v1 tags
			# A different gem needs to be used in range_request_metadata
			# and the following can be uncommented
			metadata = range_request_metadata(url, 0)

			# metadata = {}
			# mp3_url = URI.parse(url)
			# file_size = get_file_size(mp3_url)

			# if file_size > @@ID3V1_TAG_SIZE
			# 	metadata = range_request_metadata(url, ((file_size - @@ID3V1_TAG_SIZE)..file_size))
			# end

			return metadata
		end

		def range_request_metadata(url, range)
			mp3_url = URI.parse(url)
			req = Net::HTTP::Get.new(parse_full_path(mp3_url))
			http = Net::HTTP.new(mp3_url.host, mp3_url.port) 
			req.range = range
			res = http.request(req)
			metadata = {}
			file_size = get_file_size(mp3_url)

			Mp3Info.open( StringIO.open(res.body) ) do |mp3|  #do the parsing
			    metadata[:title] = mp3.tag.title 
			    metadata[:album] = mp3.tag.album 
			    metadata[:artist] = mp3.tag.artist

			    # don't know how well this will work...
			    if !mp3.tag2.empty?
			    	metadata[:length] = (file_size - mp3.tag2.io_position) * 8 / mp3.bitrate
			    else
			    	metadata[:length] = (file_size - @@ID3V1_TAG_SIZE) * 8 / mp3.bitrate
			    end
			end

			return metadata
		end

		def parse_full_path(uri)
			return uri.path + ((uri.query) ? ("?" + uri.query) : "") + ((uri.fragment) ? ("#" + uri.fragment) : "")
		end

		def get_file_size(uri)
			file_size = 0
			Net::HTTP.start(uri.host, 80) do |http|
				response = http.request_head(parse_full_path(uri))
				file_size = response['content-length'].to_i
			end
			return file_size
		end
end
