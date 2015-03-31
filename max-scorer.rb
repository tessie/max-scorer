require 'nokogiri'
require 'libnotify'
require 'open-uri'

def send_message(score)
  Libnotify.show(:body => score, :summary => score, :timeout => 2.5)
end

@score = 0

url = "http://static.cricinfo.com/rss/livescores.xml"
open(url) do |f|
    doc =Nokogiri::XML(f)
    new_score = doc.xpath("//item//description").text
    if new_score!=@score
      send_message(new_score) 
      @score = new_score
    end
end

