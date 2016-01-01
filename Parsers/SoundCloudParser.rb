# SoundCloudParser.rb

class SoundCloudParser < SpiderParser
	def initialize(url)
		@url = url
	end

	def self.can_parse?(url)
		return (URI(url).host == "soundcloud.com")
	end
end
