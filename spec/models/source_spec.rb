require 'rails_helper'

describe Source do
  context 'Associations' do
    it { should belong_to(:srpm) }
  end

  context 'Validation' do
    it { should validate_presence_of(:srpm) }

    it { should validate_presence_of(:filename) }

    it { should validate_presence_of(:size) }
  end

  it { should have_db_index(:srpm_id) }

  it 'should return Source#filename on #to_param' do
    filename = 'openbox-3.5.0.tar.gz'
    expect(Source.new(filename: filename).to_param).to eq(filename)
  end
end
