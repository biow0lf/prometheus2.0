# frozen_string_literal: true

require 'rails_helper'

describe Source do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:srpm) }

  context 'Validation' do
    it { should validate_presence_of(:filename) }

    it { should validate_presence_of(:size) }
  end

  it 'should return Source#filename on #to_param' do
    filename = 'openbox-3.5.0.tar.gz'
    expect(Source.new(filename: filename).to_param).to eq(filename)
  end
end
