require_relative "SpiderParser"

url = ARGV[0]

DecodeParserType = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first

if DecodeParserType
	parser = DecodeParserType.new(url)
	puts parser.parse(url).to_s
else
	puts "No available parsers for: " + url
end
