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
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end.parse!

track = nil

if ARGV.empty?
	# Init a track with the options provided
	track = SpiderTrack.new()
	track.set_metadata(options)
else
	# There is a URL in the arguments
	url = ARGV[0]
	DecodeParserType = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first
	if DecodeParserType 
		parser = DecodeParserType.new(url)
		track = parser.parse(url)
		track.set_metadata(options)
	elsif !options.empty?
		# Invalid url but there are options we can use
		# TODO: Flag for force new track despite bad url
		track = SpiderTrack.new(url: url)
		track.set_metadata(options)
	else
		puts "No available parsers for: " + url
	end
end

# Do something with the track
