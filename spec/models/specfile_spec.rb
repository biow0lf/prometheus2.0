require 'spec_helper'

describe Specfile do
  context "[validation]" do
    it { should belong_to :branch }
    it { should belong_to :srpm }

    it { should validate_presence_of :branch_id }
    it { should validate_presence_of :srpm_id }
    it { should validate_presence_of :spec }    

    pending "import_specfile"
  end
end
