require "opml_reader/version"
require "opml_reader/rss"
require "opml_reader/category"

require "oga"

module OpmlReader
    class OpmlReader
        attr_reader :xml, :categories, :uncategorized_name

        def initialize(filepath, uncategorized_name = "")
            @uncategoriezed_name = uncategorized_name
            @categories = []
            @xml = File.open(filepath, &:read)
        end

        def self.read(filepath, uncategorized_name = "uncategorized")
            reader = new(filepath, uncategorized_name)
            reader.parse
            reader
        end

        def get_category(name)
            @categories << Category.new(name) unless exists_category?(name)
            categories = @categories.select do |category|
                category.name == name
            end
            categories[0]
        end

        def exists_category?(name)
            category = @categories.select do |category|
                category.name == name
            end
            true if category.length > 0
        end

        def rss
            @categories.map do |category|
                category.rss
            end
        end

        def category
            @categories.map do |category|
                category.name
            end
        end

        def parse
            # type=rss is rss
            get_element(read_outlines(@xml)).each do |outline|
                if rss_node?(outline)
                    get_argument(outline)
                else
                    make_rss_with_category(outline)
                end
            end
        end

        private
        def add_rss(title, html_url, xml_url, category_name = @uncategorized_name)
            category = get_category(category_name)
            rss = RSS.new(title, html_url, xml_url, category_name)
            category.add_rss(rss)
        end

        def get_argument(outline, category = @uncategoriezed_name)
            add_rss(outline.attribute("title").value,
                outline.attribute("htmlUrl").value,
                outline.attribute("xmlUrl").value,
                category)
        end

        def read_outlines(xml)
            # outline is category or rss
            document = Oga.parse_xml(xml)
            document.xpath("//body/outline")
        end

        def get_element(nodes)
            nodes.select do |outline|
                outline.class == Oga::XML::Element
            end
        end

        def rss_node?(node)
            return false if node.attributes.length.zero?
            type = node.attribute("type")
            return false if type.nil?
            true if type.value == "rss"
        end

        def make_rss_with_category(category_node)
            category = category_node.attribute("text").value
            get_element(category_node.children).each do |node|
                get_argument(node, category) if rss_node?(node)
            end
        end
    end
end
