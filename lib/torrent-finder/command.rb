require 'claide'

module TorrentFinder
  class Command < CLAide::Command
    self.description = 'Find recent torrent or search specific torrent.'
    self.command = 'torrent-find'

    def self.options
      [
        ['--peerflix', 'launch peerflix with first match'],
        ['--site=site', 'use site, default popgo'],
        ['--search=keywords', 'search keywords instead of find recent torrent']
      ].concat(super)
    end

    def initialize(argv)
      @use_peerflix = argv.flag?('peerflix', false)
      @site = argv.option('site', "popgo")
      @search = argv.option('search')
      super
    end

    def run
      require "torrent-finder/adapters/#{@site}_adapter"
      adapter_clazz = TorrentFinder::Adapters::Registry.adapters.first
      adapter = adapter_clazz.new
      if @search
        puts adapter.search(@search)
      else
        puts adapter.list
      end
    end
  end
end