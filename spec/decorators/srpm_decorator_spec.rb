require 'rails_helper'

describe SrpmDecorator do
  let(:srpm) { Srpm.new }
  subject { decorate srpm }

  it 'does return "&ndash;" on Srpm#short_url with empty url' do
    expect(subject.short_url).to eq('&ndash;')
  end

  it 'does return "http://example.com" if url length less than 27' do
    srpm.url = 'http://example.com'
    html = subject.short_url
    expect(Nokogiri::HTML(html).css('a').attribute('href').value).to eq('http://example.com')
    expect(Nokogiri::HTML(html).css('a').children.first.text).to eq('http://example.com')
  end

  it 'does return short url if url length more than 27' do
    srpm.url = 'http://123456789012345678901234567890'
    html = subject.short_url
    expect(Nokogiri::HTML(html).css('a').attribute('href').value).to eq('http://123456789012345678901234567890')
    expect(Nokogiri::HTML(html).css('a').children.first.text).to eq('http://12345678901234567890...')
  end

  it 'does return 1.0-alt1' do
    srpm.version = '1.0'
    srpm.release = 'alt1'
    srpm.epoch = nil
    expect(subject.evr).to eq('1.0-alt1')
  end

  it 'does return 1:1.0-alt1' do
    srpm.version = '1.0'
    srpm.release = 'alt1'
    srpm.epoch = 1
    expect(subject.evr).to eq('1:1.0-alt1')
  end
end
