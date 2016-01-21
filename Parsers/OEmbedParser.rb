# OEmbedParser.rb
require_relative "Utils"

class OEmbedParser < SpiderParser
	def initialize
		@api_endpoint = nil
	end

	def parser_name
		"OEmbed"
	end

	def explode_title_and_artist?
		false
	end

	def self.can_parse?(url)
		return url.include?("oembed")
	end

	def oembed_request(api_endpoint, url)
		uri = nil
		if api_endpoint.nil?
			uri = URI(url)
		else
			uri = URI(api_endpoint)
			uri.query = [uri.query, "url=#{url}", "format=json"].compact.join('&')
		end

		return Utils.json_request(uri.to_s)
	end

	def parse(url)
		oembed = oembed_request(@api_endpoint, url)

		title = ""
		artist = ""
		if explode_title_and_artist?
			title_artist = Utils.parse_title_artist_from_title(oembed["title"])
			title = title_artist[:title]
			artist = title_artist[:artist]
		else
			title = oembed["title"]
			artist = oembed["author_name"]
		end

		return SpiderTrack.new(source: "oEmbed:#{parser_name}",
								title: title,
								artist: artist,
								url:url,
								art_url:oembed["thumbnail_url"],
								duration_ms: oembed["duration"])
	end
end
