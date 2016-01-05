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
		@@id3v1_tag_size = 128
		@@id3v2_tag_size = 256000 # arbitrary length

		# Tag at start of file
		def parse_id3v2(url)
			return range_request_metadata(url, (0..@@id3v2_tag_size))
		end

		# Tag at end of file
		def parse_id3v1(url)
			# Haven't found a way to parse partial files for id3v1 tags
			# A different gem needs to be used in range_request_metadata
			# and the following can be uncommented
			metadata = range_request_metadata(url, 0)

			# file_size = 0
			# metadata = {}
			# mp3_url = URI.parse(url)

			# Net::HTTP.start(mp3_url.host, 80) do |http|
			# 	response = http.request_head(parse_full_path(mp3_url))
			# 	file_size = response['content-length'].to_i
			# end

			# if file_size > @@id3v1_tag_size
			# 	metadata = range_request_metadata(url, ((file_size - @@id3v1_tag_size)..file_size))
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

			Mp3Info.open( StringIO.open(res.body) ) do |mp3|  #do the parsing
			    metadata[:title] = mp3.tag.title 
			    metadata[:album] = mp3.tag.album 
			    metadata[:artist] = mp3.tag.artist
			    metadata[:length] = mp3.length * 1000
			end

			return metadata
		end

		def parse_full_path(uri)
			return uri.path + ((uri.query) ? ("?" + uri.query) : "") + ((uri.fragment) ? ("#" + uri.fragment) : "")
		end
end
