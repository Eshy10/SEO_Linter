require './lib/seo_lint'
require 'nokogiri'

RSpec.describe SeoLint do
  let(:page) { Nokogiri::HTML.parse(open("index.html")) }
  describe '#has_title?' do
    it 'should return true if title is present' do
      ele = page.title
      expect(!ele.empty?).to eq(true)
    end

    it 'should return false if title is not present' do
        ele = page.title 
        expect(!ele.empty?).not_to eq(false)
    end
  end

  describe '#has_heading?' do
    it 'should return true if h1 tag is empty' do
      ele =  page.search('h1')
      expect(!ele.empty?).to eq(true)
    end

    it 'should return false if if h1 tag is not empty' do
        ele =  page.search('h1')
        expect(!ele.empty?).not_to eq(false)
    end
  end

  describe '#title_length' do
    it 'should have the number of characters in title which is less than or equal to 70' do
      ele =  page.title.size <= 70 
      expect(ele).to eq(true)
    end

    it 'should have the number of characters in title which is not greater than 70' do
      ele =  page.title.size <= 70 
      expect(ele).not_to eq(false)
    end

    context 'when the title is empty' do
      it 'should return true if title is not empty' do
        ele = page.title
        expect(!ele.empty?).to eq(true)
      end
  
      it 'should return false if title is empty' do
          ele = page.title 
          expect(!ele.empty?).not_to eq(false)
      end
    end
  end

  describe '#image_attr' do
  it 'should return true if image alt attribute is present' do
    ele = page.xpath("//img").attr('alt')
    expect(!ele.text.empty?).to eq(true)
  end

  it 'should return false if image alt attribute is not present' do
      ele = page.xpath("//img").attr('alt')
      expect(!ele.text.empty?).not_to eq(false)
  end
end

describe '#anchor_text' do
    it 'should return true if anchor text is not empty' do
      ele = page.at_xpath('//a[@href]')
      expect(!ele.text.empty?).to eq(true)
    end

    it 'should return false if anchor text is empty' do
        ele = page.at_xpath('//a[@href]') 
        expect(!ele.text.empty?).not_to eq(false)
    end
  end

  describe '#meta_attr' do
    it 'should return true if there is a meta tag' do
      ele = page.search('meta[@name]')
      expect(!ele.empty?).to eq(true)
    end

    it 'should return false if meta tag is not found' do
        ele = page.search('meta[@name]')
        expect(!ele.empty?).not_to eq(false)
    end


    context 'when the title is empty' do
      it 'should return true if all meta value is not empty' do
        expect(page.xpath("//meta[@name]/@content").all? { |attr| !attr.value.empty? }).to eq(true)
      end
  
      it 'should return false if all meta tag value is empty' do
        expect(page.xpath("//meta[@name]/@content").all? { |attr| attr.value.empty? }).to eq(false)
      end
    end
  end
end