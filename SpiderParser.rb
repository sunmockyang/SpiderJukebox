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
		@source = nil
		@title = metadata[:title]
		@artist = metadata[:artist]
		@url = metadata[:url]
		@thumbnailURL = metadata[:thumbnailURL]
		@durationMS = metadata[:durationMS]
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

	def get_thumbnail_URL
		@thumbnailURL
	end
end

require_relative "Parsers/SoundCloudParser"
