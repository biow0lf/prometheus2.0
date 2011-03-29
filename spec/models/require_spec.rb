require 'spec_helper'

describe Require do
  it { should belong_to :package }

  it { should validate_presence_of :package }
  it { should validate_presence_of :name }
end
