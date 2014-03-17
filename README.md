# TorrentFinder

Extensible command line tool to search torrent.

## Installation

Add this line to your application's Gemfile:

    gem 'torrent-finder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install torrent-finder

## Usage

Search "Magi" on popgo, then launch peerflix with first result.

```
$ torrent-finder Magi --site=popgo --peerflix
```

Search "Carl Sagans Cosmos" on eztv, and list the result.

```
$ torrent-finder "Carl Sagans Cosmos" --site=eztv
```

## Sites

Currently following sites are supported:

- popgo
- eztv

## Contributing

1. Fork it ( http://github.com/siuying/torrent-find/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
