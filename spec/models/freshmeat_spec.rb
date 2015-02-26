require 'rails_helper'

describe Freshmeat do
  it { should validate_presence_of :name }
  it { should validate_presence_of :version }
end
