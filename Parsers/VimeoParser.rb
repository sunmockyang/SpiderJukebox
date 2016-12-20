# VimeoParser.rb
require_relative "OEmbedParser"

class VimeoParser < OEmbedParser
	def initialize
		@api_endpoint = "https://vimeo.com/api/oembed.json"
	end

	def self.parser_name
		"Vimeo"
	end

	def self.can_parse?(url)
		return (URI(url).host.end_with?("vimeo.com"))
	end

	def explode_title_and_artist?
		true
	end

	def parse(url)
		track = super(url)
		if (!track.nil?)
			track.set_metadata({duration_ms: track.get_duration_ms * 1000})
		end
		return track
	end
end
