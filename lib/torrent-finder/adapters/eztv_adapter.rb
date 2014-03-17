require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'mechanize'

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
        agent = Mechanize.new
        agent.get 'http://eztv.it'
        search_form = agent.page.form('search')
        search_form.SearchString1 = "Cosmos"
        search_form.submit
        parse_html(agent.page)
      end

      protected
      def parse_html(doc)
        doc = Nokogiri::HTML(doc) if doc.is_a?(String)
        rows = doc.search("#tooltip ~ table > tr")
        rows.collect do |row| 
          name = row.xpath('./td[2]').text.strip
          url =  row.css('td > a').collect {|a| a['href'] }.select {|link| link =~ /\.torrent$/}.last rescue nil
          url = "http:#{url}" if url =~ %r{^//}
          Torrent.new(name, url)
        end.select {|row| row.name && row.url }
      end
    end
  end
end