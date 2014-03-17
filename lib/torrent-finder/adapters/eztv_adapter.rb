require 'nokogiri'
require 'open-uri'
require 'httparty'

module TorrentFinder
  module Adapters
    class EztvAdapter < Adapter
      # name of the adapter
      def name
        "eztv"
      end

      # list recently available torrent
      def list(page=0)
        url = page == 0 ? "http://eztv.it" : "http://eztv.it/page_#{page.to_s}"
        response = HTTParty.get(url)
        parse_html(response.body)
      end

      # search and return available torrent
      def search(terms)
        response = HTTParty.post("http://eztv.it/search/", :query => {"search" => "Search", "SearchString" => "", "SearchString1" => terms})
        parse_html(response.body)
      end

      protected
      def parse_html(html)
        doc = Nokogiri::HTML(html)
        rows = doc.search("#tooltip ~ table > tr")
        rows.collect do |row| 
          name = row.xpath('./td[2]').text.strip
          url = row.css('td > a.download_1').first['href'] rescue nil
          Torrent.new(name, url)
        end.select {|row| row.name && row.url }
      end
    end
  end
end