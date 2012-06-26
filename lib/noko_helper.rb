require 'nokogiri'
require 'open-uri'

module NokoHelper
  class NokoHelper
    def show_message
      
      builder = Nokogiri::XML::Builder.new do |xml|
      end
    
      return "end"
      
    end
    
    def get_xml_base
            # builder = Nokogiri::XML::Builder.new do |xml|
      # end
      
      return Nokogiri::XML::Builder.new do |xml| end
  
      # return Nokogiri::XML(builder.to_xml)

    end#def get_xml_base
    
    def get_node(xml, tag_name)
      return Nokogiri::XML::Node.new tag_name, xml
    end#def get_node

    def add_child(xml, child)
      xml.add_child(child)
    end

    def add_next_sibling(xml, child)
      xml.add_next_sibling(child)
    end

    def get_xml_string(xml)
      #puts xml.to_xml
      return xml.to_xml
    end
    
    def set_attribute(node, attr_name, attr_value)
      node[attr_name] = attr_value
    end

    def add_child(xml, child)
      xml.add_child(child)
    end
    
  end#class NokoHelper
  
  #====================================
  class HTMLParser
    def open_html(url)
      return Nokogiri::HTML(open(url))
    end
  end#class HTMLParser
end#module NokoHelper
  