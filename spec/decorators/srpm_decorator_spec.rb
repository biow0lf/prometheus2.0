require 'spec_helper'

describe SrpmDecorator do
  it "should return '&ndash;' on Srpm.short_url with empty url" do
    Srpm.new.decorate.short_url.should == '&ndash;'
  end

  it "should return 'http://example.com' if url length less than 27" do
    srpm = Srpm.new(url: 'http://example.com').decorate
    html = srpm.short_url
    Nokogiri::HTML(html).css('a').attribute('href').value.should == 'http://example.com'
    Nokogiri::HTML(html).css('a').children.first.text.should == 'http://example.com'
  end

  it "should return short url if url length more than 27" do
    srpm = Srpm.new(url: 'http://123456789012345678901234567890').decorate
    html = srpm.short_url
    Nokogiri::HTML(html).css('a').attribute('href').value.should == 'http://123456789012345678901234567890'
    Nokogiri::HTML(html).css('a').children.first.text.should == 'http://12345678901234567890...'
  end
end
