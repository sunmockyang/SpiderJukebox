# Utils.rb
require "net/http"
require "json"

class Utils
	def self.http_request(url)
		resp = Net::HTTP.get_response(URI.parse(url))
		return resp.body
	end

	def self.json_request(url)
		return JSON.parse(self.http_request(url))
	end

	def self.parse_title_artist_from_title(title)
		separators = [" - ", " / ", " /"]
		metadata = [title, ""]

		separators.each { |separator|
			if title.include?(separator)
				metadata = title.split(separator)
				break
			end
		}

		return {artist: metadata[0].lstrip.rstrip, title: metadata[1].lstrip.rstrip}
	end
end
