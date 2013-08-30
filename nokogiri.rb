require 'nokogiri'
# 标签补全
s = "<a href='http://example.com'>incomplete"
Nokogiri::HTML::fragment(s).to_xml