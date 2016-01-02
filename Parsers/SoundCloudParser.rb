# SoundCloudParser.rb
require "soundcloud"

CLIENT_ID = ""
CLIENT_SECRET = ""

class SoundCloudSpider < SpiderParser
	def initialize(url)
		# register the client
		@client = SoundCloud.new(:client_id => CLIENT_ID)
	end

	def self.can_parse?(url)
		return (URI(url).host == "soundcloud.com")
	end

	def parse(url)
		# call the resolve endpoint with a track url
		track = @client.get('/resolve', :url => url)
		return SpiderTrack.new(source: "SoundCloud",
								title:track.title,
								artist:track.user.username,
								url:url,
								art_url:track.artwork_url,
								duration_ms:track.duration)
	end
end
