module TorrentFinder
  module Adapters
    class Adapter
      # name of the adapter
      def name
        "adapter"
      end

      # list recently available torrent
      def list(page=0)
        []
      end

      # search and return available torrent
      def search(terms)
        []
      end
    end
  end
end

require_relative './adapters/eztv_adapter'