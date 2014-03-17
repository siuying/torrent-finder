require 'spec_helper'
require 'torrent-finder/adapters/popgo_adapter'

describe TorrentFinder::Adapters::PopgoAdapter do
  context "#name" do
    it "should be eztv" do 
      expect(TorrentFinder::Adapters::PopgoAdapter.name).to eq("popgo")
    end
  end

  context "#list", :vcr => {:record => :new_episodes} do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /伪恋/}).to be_true
      url = list.find{|item| item.name.include? "伪恋"}.url

      expect(url).to be_include("https://share.popgo.org/downseed")
      expect(url).to be_include("c969a5a34caac2e89718c4ed3336eb3e728be586")
    end
  end

  context "#search", :vcr => {:record => :new_episodes} do
    it "should search torrent" do
      list = subject.search("Magi")
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /魔笛/}).to be_true
    end
  end
end