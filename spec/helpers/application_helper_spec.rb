require 'spec_helper'

describe ApplicationHelper, type: :helper do
  it 'should return "/en" for url "/" and lang "en"' do
    expect(current_page('/', 'en')).to eq('/en')
  end

  it 'should change "/en/project" to "/ru/project"' do
    expect(current_page('/en/project', 'ru')).to eq('/ru/project')
  end
end
