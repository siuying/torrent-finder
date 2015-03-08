require 'spec_helper'
require 'torrent-finder/adapters/popgo_adapter'

describe TorrentFinder::Adapters::PopgoAdapter do
  context "#name" do
    it "should be popgo" do 
      expect(TorrentFinder::Adapters::PopgoAdapter.name).to eq("popgo")
    end
  end

  context "#list", :vcr => {:record => :new_episodes} do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /高达G之复国/}).to be_truthy
      url = list.find{|item| item.name.include? "高达G之复国"}.url
      expect(url).to be_include("magnet:?xt=urn:btih:BQGYKB7WR2CMAXHO53IUDGERWVEMTFQK&tr=http://t2.popgo.org:7456/annonce")
    end
  end

  context "#search", :vcr => {:record => :new_episodes} do
    it "should search torrent" do
      list = subject.search("Magi")
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /魔笛/}).to be_truthy
      expect(list.all?{|item| item[:url] =~ /^magnet/}).to be_truthy
    end
  end
end