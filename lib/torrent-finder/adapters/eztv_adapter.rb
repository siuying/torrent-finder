require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'mechanize'

module TorrentFinder
  module Adapters
    class EztvAdapter < Adapter
      # name of the adapter
      def self.name
        "eztv"
      end

      # list recently available torrent
      def list(page=0)
        url = page == 0 ? "https://eztv.ch" : "http://eztv.ch/page_#{page.to_s}"
        response = HTTParty.get(url)
        parse_html(response.body)
      end

      # search and return available torrent
      def search(terms)
        agent = Mechanize.new
        agent.get 'https://eztv.ch'
        search_form = agent.page.form('search')
        search_form.SearchString1 = terms
        search_form.submit
        parse_html(agent.page)
      end

      protected
      def parse_html(doc)
        doc = Nokogiri::HTML(doc) if doc.is_a?(String)
        rows = doc.search(".forum_header_border")
        rows.collect do |row| 
          name = row.search(".forum_thread_post .epinfo").first.text rescue nil
          url =  row.search(".forum_thread_post .magnet").first["href"] rescue nil
          Torrent.new(name, url)
        end.select {|row| row.name && row.url }
      end
    end
  end
end