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

  it "should validate_uniqueness_of :login" do
    Maintainer.create!(:name => 'Igor Zubkov',
                       :email => 'icesik@altlinux.org',
                       :login => 'icesik',
                       :team => false)
    should validate_uniqueness_of :login
  end

  it "should return Maintainer.login on .to_param" do
    Maintainer.create!(:name => 'Igor Zubkov',
                       :email => 'icesik@altlinux.org',
                       :login => 'icesik',
                       :team => false).to_param.should == 'icesik'
  end

  it "should deny change email" do
    maintainer = Maintainer.create!(:name => 'Igor Zubkov',
                                    :email => 'icesik@altlinux.org',
                                    :login => 'icesik',
                                    :team => false)
    maintainer.email = 'ldv@altlinux.org'
    maintainer.save.should be_false
  end

  it "should deny change login" do
    maintainer = Maintainer.create!(:name => 'Igor Zubkov',
                                    :email => 'icesik@altlinux.org',
                                    :login => 'icesik',
                                    :team => false)
    maintainer.login = 'ldv'
    maintainer.save.should be_false
  end

  it "should deny change name" do
    maintainer = Maintainer.create!(:name => 'Igor Zubkov',
                                    :email => 'icesik@altlinux.org',
                                    :login => 'icesik',
                                    :team => false)
    maintainer.name = 'Dmitry V. Levin'
    maintainer.save.should be_false
  end
end
