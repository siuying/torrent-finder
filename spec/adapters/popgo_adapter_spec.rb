require 'spec_helper'

describe TorrentFinder::Adapters::PopgoAdapter do
  context "#name" do
    it "should be eztv" do 
      expect(subject.name).to eq("popgo")
    end
  end

  context "#list", :vcr => :new_episode do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /伪恋/}).to be_true
    end
  end

  context "#search", :vcr => :new_episode do
    it "should search torrent" do
      list = subject.search("Magi")
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /魔笛/}).to be_true
    end
  end
end