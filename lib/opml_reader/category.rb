module OpmlReader
  class Category
    attr_reader :name, :rss
    def initialize(name)
      @name = name
      @rss = []
    end

    def add_rss(rss)
      @rss << rss
    end
  end
end
