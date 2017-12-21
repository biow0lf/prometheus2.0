# frozen_string_literal: true

require 'rails_helper'

describe Patch do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:srpm) }

  context 'Validation' do
    it { should validate_presence_of(:filename) }

    it { should validate_presence_of(:size) }
  end

  it 'should return Patch#filename on #to_param' do
    filename = 'openbox-3.4.9-alt-desktop-file.patch'
    expect(Patch.new(filename: filename).to_param).to eq(filename)
  end
end
