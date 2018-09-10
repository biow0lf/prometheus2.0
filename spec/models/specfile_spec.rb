# frozen_string_literal: true

require 'rails_helper'

describe Specfile do
   let(:branch) { create(:branch, :with_paths) }
   let(:group) { create(:group, branch: branch) }
   let(:srpm) { create(:srpm, branch: branch, group: group) }
   let(:package) { Package.find_by_id(srpm.package.id) }

   it { should be_a(ApplicationRecord) }

   it { should belong_to(:package) }

   it { should validate_presence_of(:spec) }

   it 'should import spec file' do
      file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'

      expect(Specfile).to receive(:`).with("rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" \"#{ file }\" | grep \"32 \" | sed -e 's/32 //'").and_return('openbox.spec')
      expect(Specfile).to receive(:`).with("rpm2cpio \"#{ file }\" | cpio -i --quiet --to-stdout \"openbox.spec\"").and_return('qwerty')

      expect { Specfile.import(Rpm::Base.new(file), package) }.to change(Specfile, :count).by(1)

      expect(package.specfile).not_to be_nil
      expect(package.specfile.spec).to eq('qwerty')

      specfile = Specfile.first
      expect(specfile.package).not_to be_nil
   end
end
