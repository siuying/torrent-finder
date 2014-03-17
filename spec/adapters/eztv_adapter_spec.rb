require 'spec_helper'

describe TorrentFinder::Adapters::EztvAdapter do
  context "#name" do
    it "should be eztv" do 
      expect(subject.name).to eq("eztv")
    end
  end

  context "#list" do
    it "should list first page of torrent" do
      list = subject.list
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /Astronauts Houston/}).to be_true
    end
  end

  context "#search" do
    it "should search torrent" do
      list = subject.search("Top Gear")
      expect(list).to be_a(Array)
      expect(list.any?{|item| item[:name] =~ /Top Gear/}).to be_true
    end
  end
end