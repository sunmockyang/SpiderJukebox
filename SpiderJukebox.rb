require 'optparse'
require_relative "SpiderParser"

class SpiderJukebox
	def self.parse(url, options={})
		track = nil
		force = options.delete(:force)
		parser_name = options.delete(:parser_name)

		decode_parser = (parser_name.nil?) ? self.get_parser_from_url(url) : self.get_parser_by_name(parser_name, url)
		
		if decode_parser # Valid parser found in Parsers/*.rb
			parser = decode_parser
			track = parser.parse(url)
		elsif force && !options.empty? # No valid parsers found, but force create track based on options
			track = SpiderTrack.new(url: url)
		else # TODO: add verbose option
			# puts "No available parsers for: " + url
		end

		if (!track.nil?)
			track.set_metadata(options)
		end

		return track
	end

	def self.parse_to_json(url, options={})
		return self.parse(url, options).to_json
	end

	def self.parse_to_hash(url, options={})
		track = self.parse(url, options)
		return (track) ? track.to_hash : {}
	end

	private
		@@parser_cache = {}
		def self.get_parser_from_url(url)
			# Find the correct parser type for the url
			decode_parser_type = ParserList.select{|available_parser| available_parser.can_parse?(url)}.first
			return get_parser_from_cache(decode_parser_type, url)
		end

		def self.get_parser_by_name(name, url)
			decode_parser_type = ParserList.select{|parser| parser.parser_name == name}.first
			return get_parser_from_cache(decode_parser_type, url)
		end

		def self.get_parser_from_cache(parser_type, url)
			parser = nil
			if !parser_type.nil?
				# Cache parser if an instance doesn't exist
				if !@@parser_cache.has_key?(parser_type)
					@@parser_cache[parser_type] = parser_type.new
				end
				parser = @@parser_cache[parser_type]
			end
			return parser
		end

		def self.clear_parser_cache
			@@parser_cache.clear
		end
end

# For use with command line args
usage_banner = "Usage: ruby SpiderJukebox.rb [url] [options]"

if ARGV.empty?
	 puts usage_banner
	 exit
end

options = {}
parser_type = nil
OptionParser.new do |opts|
	opts.banner = usage_banner
	opts.separator ""
	opts.separator "Specific options:"

	opts.on('-t', '--title=TITLE', "Override the title of the track.") { |title| options[:title] = title }
	opts.on('-a', '--artist=ARTIST', "Override the artist of the track.") { |artist| options[:artist] = artist }
	opts.on('-r', '--album_art=ALBUMART', "Override the album art url of the track.") { |art_url| options[:art_url] = art_url }
	opts.on('-d', '--duration=DURATION', "Override the duration (ms) of the track.") { |duration_ms| options[:duration_ms] = duration_ms }
	opts.on('-f', '--force', "Force create track without valid url") { options[:force] = true }
	opts.on('-p', '--parser_type=PARSERTYPE', "Specify a parser to decode the provided url") { |parser_name| options[:parser_name] = parser_name }
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end.parse!

url = ARGV[0] || ""
if url || !options.empty?
	track = SpiderJukebox.parse(url, options)
	if track.nil?
		puts "Unable to parse #{url}"
	else
		puts track
	end
end
