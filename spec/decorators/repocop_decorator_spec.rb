require 'spec_helper'

describe RepocopDecorator do
  it 'should return &nbsp; if repocop message is empty' do
    Repocop.new.decorate.show_message.should eq('&nbsp;')
  end

  it 'should return message if repocop message exists' do
    Repocop.new(message: 'Text').decorate.show_message.should eq('Text')
  end
end
