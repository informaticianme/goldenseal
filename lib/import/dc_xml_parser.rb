module Import
  class DcXmlParser

    NAMESPACES = {
      'dc' => "http://purl.org/dc/elements/1.1/",
      'oai_dc' => "http://www.openarchives.org/OAI/2.0/oai_dc/"
    }

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def xml
      @xml ||= Nokogiri::XML(File.read(file))
    end

    # Gather the attributes for all the records in the file.
    def records
      xml.xpath('records/record').inject([]) do |records, node|
        records << attributes_for_record(node)
      end
    end

    # Gather the attributes for one record.
    # @param [Nokogiri::XML::Node] The node for a single record in the XML file
    def attributes_for_record(node)
      field_map.each_with_object({}) do |(field, xpath), attrs|
        attrs[field] = text_for(xpath, node)
      end
    end

    # Map the name of the field to its xpath in the XML file
    # (from the <record> node).
    def field_map
      { identifier: './header/identifier',
        title:      './metadata/oai_dc:dc/dc:title',
        language:   './metadata/oai_dc:dc/dc:language'
      }
    end

    # Get the text for the element(s) at the given xpath within
    # the given node, and strip out extra whitespace.
    def text_for(xpath, node)
      node.xpath(xpath, NAMESPACES).map do |element|
        element.text.strip
      end
    end

  end
end
