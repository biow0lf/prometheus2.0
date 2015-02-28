require 'rails_helper'

describe Patch do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :srpm }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :srpm }
    it { should validate_presence_of :filename }
    it { should validate_presence_of :size }
  end

  it { should have_db_index :branch_id }
  it { should have_db_index :srpm_id }

  it 'should return Patch#filename on #to_param' do
    filename = 'openbox-3.4.9-alt-desktop-file.patch'
    expect(Patch.new(filename: filename).to_param).to eq(filename)
  end
end
