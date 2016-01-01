require_relative "Spider"

url = ARGV[0]

DecodeSpiderType = Spider.descendants.select{|available_spider| available_spider.can_spider?(url)}.first

if DecodeSpiderType
	spider = DecodeSpiderType.new(url)
	puts spider.get_URL
else
	puts "No available parsers for: " + url
end
