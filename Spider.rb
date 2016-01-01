# Spider.rb

require "uri"

class Spider
	def initialize(url)
		@title = ""
		@artist = ""
		@url = url
		@thumbnailURL = ""
	end

	def self.descendants
		ObjectSpace.each_object(Class).select { |klass| klass < self }
	end

	def self.can_spider?(url)
		return false
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

require_relative "Spiders/SoundCloudSpider"
