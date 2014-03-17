module TorrentFinder
  module Adapters
    class Registry
      @@adapters = []
      
      def self.register(adapter)
        @@adapters << adapter
      end

      def self.adapters
        @@adapters
      end
    end

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

      def self.inherited(c)
        Registry.register(c)
      end
    end
  end
end