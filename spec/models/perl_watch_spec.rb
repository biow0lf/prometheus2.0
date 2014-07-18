require 'spec_helper'

describe PerlWatch, :type => :model do
  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
  end

  it 'should import data from CPAN' do
    page = `cat spec/data/02packages.details.txt`
    url = 'http://www.cpan.org/modules/02packages.details.txt'
    FakeWeb.register_uri(:get,
                         url,
                         response: page)
    expect {
      PerlWatch.import_data(url)
    }.to change { PerlWatch.count }.from(0).to(1)
    expect(PerlWatch.count).to eq(1)
    perlwatch = PerlWatch.first
    expect(perlwatch.name).to eq('AnyEvent::ZeroMQ')
    expect(perlwatch.version).to eq('0.01')
    expect(perlwatch.path).to eq('J/JR/JROCKWAY/AnyEvent-ZeroMQ-0.01.tar.gz')
  end
end
