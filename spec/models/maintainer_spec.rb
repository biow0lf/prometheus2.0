require 'spec_helper'

describe Maintainer do
  it { should have_one :leader }
  it { should have_many :acls }
  it { should have_many :teams }
  it { should have_many(:srpms).through(:acls) }
  it { should have_many :gears }
  it { should have_many :ftbfs }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :login }

  # wtf? why?
  pending { should validate_uniqueness_of :login }

  it "should return Maintainer.login on .to_param" do
    Maintainer.create(:name => 'Igor Zubkov',
                      :email => 'icesik@altlinux.org',
                      :login => 'icesik',
                      :team => false).to_param.should == 'icesik'
  end
end
