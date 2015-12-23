require_relative "Spider"

url = ARGV[0]

# TODO: make spider a nil var and remove parserFound
spider = Spider.new("")
parserFound = false

AvailableSpiders.each{ |availableSpider|
	if availableSpider.canSpider?(url)
		parserFound = true
		spider = availableSpider.new(url)
		break
	end
}

if !parserFound
	puts "No available parsers for: " + url
end

puts spider.getURL
