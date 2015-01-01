require 'spec_helper'
require 'torrent-finder/adapters/nyaa_adapter'

describe TorrentFinder::Adapters::NyaaAdapter do
  context "#name" do
    it "should be nyaa" do 
      expect(TorrentFinder::Adapters::NyaaAdapter.name).to eq("nyaa")
    end
  end

  context "#list", :vcr => {:record => :new_episodes} do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.size > 0).to be_truthy
      expect(list.any?{|item| item[:name] =~ /Denpa Onna to Seishun Otoko/}).to be_truthy
    end
  end

  context "#search", :vcr => {:record => :new_episodes} do
    it "should search torrent" do
      list = subject.search("SAO II")
      expect(list).to be_a(Array)
      expect(list.size > 0).to be_truthy
      expect(list.any?{|item| item[:name] =~ /Sword Art Online II - 21/}).to be_truthy
    end
  end
end