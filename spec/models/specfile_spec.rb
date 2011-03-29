require 'spec_helper'

describe Specfile do
  it { should belong_to :branch }
  it { should belong_to :srpm }

  it { should validate_presence_of :branch }
  it { should validate_presence_of :srpm }
  it { should validate_presence_of :spec }

  pending "import_specfile"
end
