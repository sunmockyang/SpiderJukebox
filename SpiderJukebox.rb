require 'optparse'
require_relative "SpiderParser"

class SpiderJukebox
	def self.parse(url, options={})
		track = nil
		force = options.delete(:force)

		decode_parser = self.get_parser(url)
		if decode_parser # Valid parser found in Parsers/*.rb
			parser = decode_parser
			track = parser.parse(url)
			track.set_metadata(options)
		elsif force # No valid parsers found, but force create track based on options
			track = SpiderTrack.new(url: url)
			track.set_metadata(options)
		else # TODO: add verbose option
			puts "No available parsers for: " + url
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

	@@parser_cache = {}
	def self.get_parser(url)
		# Find the correct parser type for the url
		decode_parser_type = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first
		parser = nil
		
		if !decode_parser_type.nil?
			# Cache parser if an instance doesn't exist
			if !@@parser_cache.has_key?(decode_parser_type)
				@@parser_cache[decode_parser_type] = decode_parser_type.new(url)
			end
			parser = @@parser_cache[decode_parser_type]
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
OptionParser.new do |opts|
	opts.banner = usage_banner
	opts.separator ""
	opts.separator "Specific options:"

	opts.on('-t', '--title=TITLE', "Override the title of the track.") { |title| options[:title] = title }
	opts.on('-a', '--artist=ARTIST', "Override the artist of the track.") { |artist| options[:artist] = artist }
	opts.on('-r', '--album_art=ALBUMART', "Override the album art url of the track.") { |art_url| options[:art_url] = art_url }
	opts.on('-d', '--duration=DURATION', "Override the duration (ms) of the track.") { |duration_ms| options[:duration_ms] = duration_ms }
	opts.on('-f', '--force', "Force create track without valid url") { options[:force] = true }
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end.parse!

url = ARGV[0] || ""
if url || !options.empty?
	puts SpiderJukebox.parse(url, options)
end
