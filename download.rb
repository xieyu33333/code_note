require 'open-uri'
File.open(saved_filename , "wb") do |file|
	file << open('http://example.com/image.png').read	
end