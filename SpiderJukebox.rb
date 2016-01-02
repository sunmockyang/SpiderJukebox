require 'optparse'
require_relative "SpiderParser"

options = {}
OptionParser.new do |opt|
	opt.banner = "Usage: ruby SpiderJukebox.rb [url] [options]"
	opt.separator ""
	opt.separator "Specific options:"

	opt.on('-t', '--title=TITLE', "Override the title of the track.") { |title| options[:title] = title }
	opt.on('-a', '--artist=ARTIST', "Override the artist of the track.") { |artist| options[:artist] = artist }
	opt.on('-r', '--album-art=ALBUMART', "Override the album art url of the track.") { |album_art| options[:album_art] = album_art }
	opt.on('-d', '--duration=DURATION', "Override the duration (ms) of the track.") { |duration_ms| options[:duration_ms] = duration_ms }
	opt.on_tail("-h", "--help", "Show this message") do
		puts opt
		exit
	end
end.parse!

url = ARGV[0]

DecodeParserType = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first

if DecodeParserType
	parser = DecodeParserType.new(url)
	track = parser.parse(url)
	track.set_metadata(options)
	puts track.to_s
elsif options.empty?
	puts "No available parsers for: " + url
end
