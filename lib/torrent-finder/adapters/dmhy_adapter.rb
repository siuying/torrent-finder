require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'mechanize'

module TorrentFinder
  module Adapters
    class DmhyAdapter < Adapter
      # name of the adapter
      def self.name
        "dmhy"
      end

      # list recently available torrent
      def list(page=0)
        url = page == 0 ? "http://share.dmhy.org/" : "http://share.dmhy.org/topics/list/page/#{(page+1).to_s}"
        response = HTTParty.get(url)
        parse_html(response.body)
      end

      # search and return available torrent
      def search(terms)
        response = HTTParty.get("http://share.dmhy.org/topics/list", :query => {"keyword" => terms})
        parse_html(response.body)
      end

      protected
      def parse_html(html)
        doc = Nokogiri::HTML(html)
        rows = doc.search("#topic_list tr")
        rows.collect do |row| 
          title = row.search('td.title').first
          if title
            title.search(".tag").remove
            name = title.search('./a').first.text.strip
          end
          link = row.search('a.arrow-magnet').first["href"] rescue nil
          Torrent.new(name, link)
        end.select {|row| row.name && row.url && row.url != "" }
      end
    end
  end
end