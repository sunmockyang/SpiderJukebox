# SoundCloudParser.rb
require_relative "OEmbedParser"

class SoundCloudParser < OEmbedParser
	def initialize
		@api_endpoint = "https://soundcloud.com/oembed"
	end

	def self.parser_name
		"SoundCloud"
	end

	def self.can_parse?(url)
		return (URI(url).host.end_with?("soundcloud.com"))
	end
end
