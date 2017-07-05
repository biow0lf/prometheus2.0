require 'rails_helper'

describe RPM::SourceDecorator do
  describe '#as_json' do
    let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

    let(:rpm) { RPM::Source.new(file) }

    before { expect(rpm).to receive(:name).and_return('catpkt').twice }

    before { expect(rpm).to receive(:version).and_return('1.0').twice }

    before { expect(rpm).to receive(:release).and_return('alt5').twice }

    before { expect(rpm).to receive(:epoch).and_return(20131206) }

    before { expect(rpm).to receive(:group).and_return('Text tools') }

    before { expect(rpm).to receive(:summary).and_return('FTS Packet Viewer') }

    before { expect(rpm).to receive(:license).and_return('BSD-like') }

    before { expect(rpm).to receive(:url).and_return('http://xmms.org') }

    before { expect(rpm).to receive(:description).and_return('Viewer for out/in-bound ftn-packets.') }

    before { expect(rpm).to receive(:vendor).and_return('ALT Linux Team') }

    before { expect(rpm).to receive(:distribution).and_return('ALT Linux') }

    before { expect(rpm).to receive(:buildtime).and_return(Time.zone.local(2012, 10, 5, 14, 59, 45)) }

    before { expect(rpm).to receive(:changelogtime).and_return(Time.zone.local(2012, 10, 5, 12, 0)) }

    before { expect(rpm).to receive(:changelogname).and_return('Igor Zubkov <icesik@altlinux.org> 1.0-alt5') }

    before { expect(rpm).to receive(:changelogtext).and_return('- rebuilt for debuginfo') }

    subject { rpm.decorate.as_json }

    its([:name]) { should eq('catpkt') }

    its([:version]) { should eq('1.0') }

    its([:release]) { should eq('alt5') }

    its([:epoch]) { should eq(20131206) }

    its([:filename]) { should eq('catpkt-1.0-alt5.src.rpm') }

    its([:groupname]) { should eq('Text tools') }

    its([:summary]) { should eq('FTS Packet Viewer') }

    its([:license]) { should eq('BSD-like') }

    its([:url]) { should eq('http://xmms.org') }

    its([:description]) { should eq('Viewer for out/in-bound ftn-packets.') }

    its([:vendor]) { should eq('ALT Linux Team') }

    its([:distribution]) { should eq('ALT Linux') }

    its([:buildtime]) { should eq(Time.zone.local(2012, 10, 5, 14, 59, 45)) }

    its([:changelogtime]) { should eq(Time.zone.local(2012, 10, 5, 12, 0)) }

    its([:changelogname]) { should eq('Igor Zubkov <icesik@altlinux.org> 1.0-alt5') }

    its([:changelogtext]) { should eq('- rebuilt for debuginfo') }
  end
end
