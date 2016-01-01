require_relative "SpiderParser"

url = ARGV[0]

DecodeParserType = SpiderParser.descendants.select{|available_parser| available_parser.can_parse?(url)}.first

if DecodeParserType
	parser = DecodeParserType.new(url)
	puts parser.get_URL
else
	puts "No available parsers for: " + url
end
