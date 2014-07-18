require 'spec_helper'

describe Freshmeat, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :version }
end
