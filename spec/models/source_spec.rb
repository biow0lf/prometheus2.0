require 'rails_helper'

describe Source do
  context 'Associations' do
    it { is_expected.to belong_to :srpm }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :srpm }
    it { is_expected.to validate_presence_of :filename }
    it { is_expected.to validate_presence_of :size }
  end

  it { is_expected.to have_db_index :srpm_id }

  it 'should return Source#filename on #to_param' do
    filename = 'openbox-3.5.0.tar.gz'
    expect(Source.new(filename: filename).to_param).to eq(filename)
  end
end
