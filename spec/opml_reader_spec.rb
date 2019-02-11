require "spec_helper"

describe OpmlReader do
  before do
    @filepath = File.dirname(__FILE__) + "/feedly.opml"
  end

  it "has a version number" do
    expect(OpmlReader::VERSION).not_to be nil
  end

  describe "read opml" do
    before do
      @reader = OpmlReader::OpmlReader.new(@filepath)
    end

    it "open opml" do
      expect(@reader.xml).to_not be_nil
    end
  end

  describe "read" do
    it "show" do
      @reader = OpmlReader::OpmlReader.read(@filepath)
      @reader.categories.each do |category|
        category.rss.each do |rss|
          p "#{category.name}/#{rss.title} (#{rss.xml_url})"
        end
      end
      p @reader.category
      p @reader.rss
    end

    it "read" do
      @reader = OpmlReader::OpmlReader.read(@filepath)
      expect(@reader.categories.class).to eq Array
    end
  end
end
