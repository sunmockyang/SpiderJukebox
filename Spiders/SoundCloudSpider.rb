# SoundCloudSpider.rb

class SoundCloudSpider < Spider
	def initialize(url)
		@url = url
	end

	def self.canSpider?(url)
		return (URI(url).host == "soundcloud.com")
	end
end
