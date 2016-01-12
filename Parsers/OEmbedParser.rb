# OEmbedParser.rb
require "net/http"
require "json"
require_relative "Utils"

class OEmbedParser < SpiderParser
	def self.parser_name
		"oEmbed"
	end

	def self.can_parse?(url)
		return url.include?("oembed")
	end

	def parse(url)
		oembed = Utils.json_request(url)
		return SpiderTrack.new(source: "#{OEmbedParser.parser_name}:#{oembed['provider_name']}",
								title:oembed["title"],
								artist:oembed["author_name"],
								url:url,
								art_url:oembed["thumbnail_url"])
	end
end
