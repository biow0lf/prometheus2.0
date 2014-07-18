require 'spec_helper'

describe SrpmDecorator do
  it 'should return "&ndash;" on Srpm.short_url with empty url' do
    expect(Srpm.new.decorate.short_url).to eq('&ndash;')
  end

  it 'should return "http://example.com" if url length less than 27' do
    srpm = Srpm.new(url: 'http://example.com').decorate
    html = srpm.short_url
    expect(Nokogiri::HTML(html).css('a').attribute('href').value).to eq('http://example.com')
    expect(Nokogiri::HTML(html).css('a').children.first.text).to eq('http://example.com')
  end

  it 'should return short url if url length more than 27' do
    srpm = Srpm.new(url: 'http://123456789012345678901234567890').decorate
    html = srpm.short_url
    expect(Nokogiri::HTML(html).css('a').attribute('href').value).to eq('http://123456789012345678901234567890')
    expect(Nokogiri::HTML(html).css('a').children.first.text).to eq('http://12345678901234567890...')
  end

  it 'should return 1.0-alt1' do
    srpm = Srpm.new(version: '1.0', release: 'alt1', epoch: nil).decorate
    expect(srpm.evr).to eq('1.0-alt1')
  end

  it 'should return 1:1.0-alt1' do
    srpm = Srpm.new(version: '1.0', release: 'alt1', epoch: '1').decorate
    expect(srpm.evr).to eq('1:1.0-alt1')
  end
end
