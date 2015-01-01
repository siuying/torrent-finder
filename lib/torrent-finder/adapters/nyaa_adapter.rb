require 'nokogiri'
require 'open-uri'
require 'httparty'

module TorrentFinder
  module Adapters
    class NyaaAdapter < Adapter
      # name of the adapter
      def self.name
        "nyaa"
      end

      # list recently available torrent
      def list(page=0)
        url = page == 0 ? "http://www.nyaa.se/" : "http://www.nyaa.se/?offset=#{(page).to_s}"
        response = HTTParty.get(url)
        parse_html(response.body)
      end

      # search and return available torrent
      def search(terms)
        response = HTTParty.get("http://www.nyaa.se/?page=search&term=", :query => {"term" => terms})
        parse_html(response.body)
      end

      protected
      def parse_html(html)
        doc = Nokogiri::HTML(html)
        rows = doc.search(".tlist .tlistrow")
        rows.collect do |row| 
          name = row.search('.tlistname').text rescue nil
          url =  row.search('.tlistdownload a').first['href'] rescue nil
          Torrent.new(name, url)
        end.select {|row| row.name && row.url }
      end
    end
  end
end