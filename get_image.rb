require 'open-uri'
require 'nokogiri'

url = 'https://rank1-media.com/I0003357'
puts "cd app/assets/images"

3.times do |i|
 charset = nil
 html = open(url + "/&page=#{i}") do |f|
     charset = f.charset
     f.read
 end

 doc = Nokogiri::HTML.parse(html, nil, charset)

 #doc.css('img').each do |node|
 #    if node.attr('src') =~ /parts/
 #        p "https://rank1-media.com/#{node.attr('src')}"
 #    end
 #end

 doc.css('.item_list').each do |node|
      node.css('img').each do |item|
        puts "curl https://rank1-media.com/#{item.attr('src')} -o #{item.attr('alt')}.jpg"
      end
 end
end