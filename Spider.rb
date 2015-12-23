# Spider.rb

require "uri"

class Spider
	def initialize(url)
		@title = ""
		@artist = ""
		@url = url
		@thumbnailURL = ""
	end

	def self.canSpider?(url)
		return false
	end

	def getTitle
		@title
	end

	def getArtist
		@artist
	end

	def getURL
		@url
	end

	def getThumbnailURL
		@thumbnailURL
	end
end

require_relative "Spiders/SoundCloudSpider"

AvailableSpiders = [SoundCloudSpider]
