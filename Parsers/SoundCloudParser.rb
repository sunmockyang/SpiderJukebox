# SoundCloudParser.rb
require "soundcloud"

CLIENT_ID = ""
CLIENT_SECRET = ""

class SoundCloudSpider < SpiderParser
	# register the client
	@@client = SoundCloud.new(:client_id => CLIENT_ID)
	def initialize(url)
		# call the resolve endpoint with a track url
		track = @@client.get('/resolve', :url => url)

		@url = url
		@title = track.title
		@artist = track.user.username
		@thumbnailURL = track.artwork_url
	end

	def self.can_parse?(url)
		return (URI(url).host == "soundcloud.com")
	end
end
