require 'nokogiri' 
require 'colorize'

class SeoLint
   attr_accessor :page
    def initialize
     @page = Nokogiri::HTML.parse(open("index.html"))
    end

    def has_title?
        ele = @page.title
        if ele.empty?
          puts '[TEST FAILED] : '.red + 'element required in the title tag'
        else
            puts '[TEST PASSED] : '.green + 'element present in the title tag'  
        end
    end

    def has_heading?
     ele = @page.search('h1')
     if ele.empty? || ele.text.empty?
        puts '[TEST FAILED] : '.red + 'heading tag not found'
      else
          puts '[TEST PASSED] : '.green + 'heading tag found'  
      end

    end

    def title_length
        if @page.title.size <= 70
        puts '[TEST PASSED] : '.green + 'Title is not more than 70 characters'
        else
        puts '[TEST FAILED] : '.red + 'Title is more than 70 characters'
        end
    end

    def image_attr
       img_atr = @page.xpath("//img").attr('alt')
       if img_atr.text.empty?
        puts '[TEST FAILED] : '.red + 'alt attribute not found in image tag'
      else
          puts '[TEST PASSED] : '.green + 'alt attribute found in image tag'  
      end
    end

    def anchor_txt
    element = @page.at_xpath('//a[@href]')
    if element.text.empty?
        puts '[TEST FAILED] : '.red + 'anchor text not found'
      else
          puts '[TEST PASSED] : '.green + 'anchor text found'  
      end
    end

    def meta_attr
      @page.xpath("//meta[@name='fitness']/@content").each do |attr|
        if attr.value.empty?
          puts '[TEST FAILED] : '.red + 'meta description not found'
        else
          puts '[TEST PASSED] : '.green + 'meta description found'  
        end
      end
    end

    def validate
      self.has_title?
      self.has_heading?
      self.title_length
      self.image_attr
      self.anchor_txt
      self.meta_attr
    end
    
end






