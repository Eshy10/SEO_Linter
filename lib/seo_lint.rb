require 'nokogiri'
require 'colorize'

class SeoLint
  attr_accessor :page
  def initialize
    @page = Nokogiri::HTML.parse(open('index.html'))
  end

  def title?
    ele = @page.search('title')
    if ele.empty? || ele.text.empty?
      puts '[TEST FAILED] : '.red + 'element required in the title tag'
    else
      puts '[TEST PASSED] : '.green + 'element present in the title tag'
    end
  end

  def heading?
    ele = @page.search('h1')
    if ele.empty? || ele.text.empty?
      puts '[TEST FAILED] : '.red + 'heading tag not found'
    else
      puts '[TEST PASSED] : '.green + 'heading tag found'
    end
  end

  def title_length
    ele = @page.search('title')
    if ele.text.empty?
      puts '[TEST FAILED] : '.red + 'Title not found'
    elsif @page.title.size <= 70
      puts '[TEST PASSED] : '.green + 'Title is not more than 70 characters'
    else
      puts '[TEST FAILED] : '.red + 'Title is more than 70 characters'
    end
  end

  def image_attr
    img_atr = @page.xpath('//img').attr('alt')
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
    meta = @page.search('meta[@name]')
    if meta.empty?
      puts '[TEST FAILED] : '.red + 'meta tag not found'
    else
      @page.xpath('//meta[@name]/@content').all? do |attr|
        if attr.value.empty?
          puts '[TEST FAILED] : '.red + 'meta description not found'
        else
          puts '[TEST PASSED] : '.green + 'meta description found'
        end
      end
    end
  end

  def validate
    title?
    heading?
    title_length
    image_attr
    anchor_txt
    meta_attr
  end
end
