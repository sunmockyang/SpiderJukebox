# SpiderParser.rb

require "uri"
require "json"

class SpiderParser
	def initialize(url)
	end

	def self.descendants
		ObjectSpace.each_object(Class).select { |klass| klass < self }
	end

	def self.can_parse?(url)
		return false
	end

	def parse(url)
		return SpiderTrack.new
	end
end

class SpiderTrack
	def initialize(metadata={})
		@metadata = {
			source: nil,
			title: "",
			artist: "",
			url: "",
			art_url: "",
			duration_ms: 0
		}
		self.set_metadata(metadata)
	end

	def set_metadata(metadata={})
		@metadata = @metadata.merge(metadata){|key, oldval, newval| (!newval.nil?) ? newval : oldval}
	end

	def to_s
		return @metadata[:artist] + " - " + @metadata[:title] + " (" + @metadata[:url] + ")"
	end

	def to_json
		@metadata.to_json
	end

	def to_hash
		@metadata
	end

	def get_title
		@metadata[:title]
	end

	def get_artist
		@metadata[:artist]
	end

	def get_url
		@metadata[:url]
	end

	def get_art_url
		@metadata[:art_url]
	end

	def get_duration_ms
		@metadata[:duration_ms]
	end
end

require_relative "Parsers/SoundCloudParser"
require_relative "Parsers/MP3Parser"
