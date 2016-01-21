# YouTubeParser.rb
require_relative "OEmbedParser"

class YouTubeParser < OEmbedParser
	def initialize
		@api_endpoint = "http://www.youtube.com/oembed"
	end

	def parser_name
		"YouTube"
	end

	def self.can_parse?(url)
		return (URI(url).host.end_with?("youtube.com"))
	end

	def explode_title_and_artist?
		true
	end
end
