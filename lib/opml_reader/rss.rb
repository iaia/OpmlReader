module OpmlReader
  class RSS
    attr_reader :title, :html_url, :xml_url, :category
    def initialize(title, html_url, xml_url, category = "uncategorized")
      @title = title
      @html_url = html_url
      @xml_url = xml_url
      @category = category
    end
  end
end
