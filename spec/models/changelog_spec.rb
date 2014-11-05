require 'spec_helper'

describe Changelog, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :srpm }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :srpm }
    it { is_expected.to validate_presence_of :changelogtime }
    it { is_expected.to validate_presence_of :changelogname }
    it { is_expected.to validate_presence_of :changelogtext }
  end

  it { is_expected.to have_db_index :srpm_id }

  it 'should import changelogs' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    expect(Changelog).to receive(:`)
      .with("export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{ file }").and_return("1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n")

    expect { Changelog.import(file, srpm) }
      .to change { Changelog.count }.from(0).to(2)
  end
end
