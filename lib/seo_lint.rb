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
     if ele.empty?
        puts '[TEST FAILED] : '.red + 'heading tag not found'
      else
          puts '[TEST PASSED] : '.green + 'heading tag found'  
      end

    end
    
end






