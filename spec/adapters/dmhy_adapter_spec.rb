require 'spec_helper'
require 'torrent-finder/adapters/dmhy_adapter'

describe TorrentFinder::Adapters::DmhyAdapter do
  context "#name" do
    it "should be dmhy" do 
      expect(TorrentFinder::Adapters::DmhyAdapter.name).to eq("dmhy")
    end
  end

  context "#list", :vcr => {:record => :new_episodes} do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /高达G之复国/}).to be_truthy
      url = list.find{|item| item.name.include? "高达G之复国"}.url
      expect(url).to be_include("magnet:?xt=urn:btih:BQGYKB7WR2CMAXHO53IUDGERWVEMTFQK&dn=&tr=http%3A%2F%2F208.67.16.113%3A8000%2Fannounce&tr=udp%3A%2F%2F208.67.16.113%3A8000%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker.publicbt.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker.prq.to%2Fannounce&tr=http%3A%2F%2Ft2.popgo.org%3A7456%2Fannonce&tr=http%3A%2F%2F208.67.16.113%3A8000%2Fannonuce")
    end
  end

  context "#search", :vcr => {:record => :new_episodes} do
    it "should search torrent" do
      list = subject.search("ALDNOAH")
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /Aldnoah.Zero 第21話 BIG5 720P MP4/}).to be_truthy
      expect(list.all?{|item| item[:url] =~ /^magnet/}).to be_truthy
    end
  end
end