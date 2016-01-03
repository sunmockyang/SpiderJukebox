# SpiderParser.rb

require "uri"

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
		return SpiderTrack.new("", "", url, "", 0)
	end
end

class SpiderTrack
	def initialize(metadata={})
		# Maybe I ought to make these fields all in a hash
		@source = nil
		@title = ""
		@artist = ""
		@url = ""
		@art_url = ""
		@duration_ms = 0
		self.set_metadata(metadata)
	end

	def set_metadata(metadata={})
		@title = metadata[:title] || @title
		@artist = metadata[:artist] || @artist
		@url = metadata[:url] || @url
		@art_url = metadata[:art_url] || @art_url
		@duration_ms = metadata[:duration_ms] || @duration_ms
	end

	def to_s
		return @artist + " - " + @title + " (" + @url + ")"
	end

	def get_title
		@title
	end

	def get_artist
		@artist
	end

	def get_URL
		@url
	end

	def get_art_URL
		@art_url
	end

	def get_duration_ms
		@duration_ms
	end
end

require_relative "Parsers/SoundCloudParser"
