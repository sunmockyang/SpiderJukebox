require 'optparse'
require_relative "SpiderParser"

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

class SpiderJukebox
	@@parser_cache = {}

	def self.parse(url, options={})
		track = nil
		force = options.delete(:force)
		decode_parser = self.get_parser(url)
		if decode_parser
			parser = decode_parser
			track = parser.parse(url)
			track.set_metadata(options)
		elsif force
			# Invalid url but there are options we can use
			track = SpiderTrack.new(url: url)
			track.set_metadata(options)
		else
			puts "No available parsers for: " + url
		end

		return track
	end

	def self.parse_to_json(url, options={})
		return self.parse(url, options).to_json
	end

	def self.get_parser(url)
		decode_parser_type = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first
		parser = nil
		
		if !decode_parser_type.nil?
			if @@parser_cache[decode_parser_type]
				parser = @@parser_cache[decode_parser_type]
			else
				parser = decode_parser_type.new(url)
				@@parser_cache[decode_parser_type] = decode_parser_type.new(url)
			end
		end

		return parser
	end

	def self.clear_parser_cache
		@@parser_cache.clear
	end
end

url = ARGV[0] || ""
if url || !options.empty?
	puts SpiderJukebox.parse(url, options)
end
