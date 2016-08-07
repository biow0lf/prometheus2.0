require 'rails_helper'

describe PackageDecorator do
  describe '#as_json' do
    let(:created_at) { double }

    let(:updated_at) { double }

    let(:buildtime) { double }

    let(:package) do
      stub_model Package, id: 123, filename: 'azaza', srpm_id: 2, name: 'sudo', version: '1', release: 'fail', epoch: 2, arch: '3',
                 summary: 'awesome package', license: 'MIT', url: 'www', description: 'thats all', group_id: 3, md5: 'blablabla',
                 groupname: 'main', sourcepackage: 'nope', size: 1
    end

    before { expect(package).to receive(:created_at).and_return(created_at) }

    before { expect(package).to receive(:buildtime).and_return(buildtime) }

    before { expect(package).to receive(:updated_at).and_return(updated_at) }

    before { expect(created_at).to receive(:iso8601).and_return(created_at) }

    before { expect(updated_at).to receive(:iso8601).and_return(updated_at) }

    before { expect(buildtime).to receive(:iso8601).and_return(buildtime) }

    subject { package.decorate.as_json.symbolize_keys }

    its([:id]) { should eq(123) }

    its([:filename]) { should eq('azaza') }

    its([:srpm_id]) { should eq(2) }

    its([:name]) { should eq('sudo') }

    its([:version]) { should eq('1') }

    its([:release]) { should eq('fail') }

    its([:epoch]) { should eq(2) }

    its([:arch]) { should eq('3') }

    its([:summary]) { should eq('awesome package') }

    its([:license]) { should eq('MIT') }

    its([:url]) { should eq('www') }

    its([:description]) { should eq('thats all') }

    its([:group_id]) { should eq(3) }

    its([:md5]) { should eq('blablabla') }

    its([:groupname]) { should eq('main') }

    its([:sourcepackage]) { should eq('nope') }

    its([:size]) { should eq(1) }

    its([:buildtime]) { should eq(buildtime) }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end
end
