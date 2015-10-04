require 'rails_helper'

describe SrpmDecorator do
  describe '#as_json' do
    let(:created_at) { '2014-01-15T20:05:29Z' }

    let(:updated_at) { '2015-04-11T13:32:15Z' }

    let(:buildtime) { '2014-01-15T18:59:48Z' }

    let(:branch) do
      stub_model Branch,
                 id: 1,
                 name: 'Sisyphus'
    end

    let(:srpm) do
      stub_model Srpm,
                 id: 336_994,
                 branch: branch,
                 name: 'glibc',
                 version: '2.17',
                 release: 'alt8',
                 epoch: 6,
                 summary: 'The GNU libc libraries',
                 license: 'LGPLv2+, LGPLv2+ with exceptions, GPLv2+',
                 group_id: 1_083,
                 groupname: 'System/Base',
                 url: 'http://www.gnu.org/software/glibc/',
                 description: 'The GNU C library defines...',
                 buildtime: buildtime,
                 filename: 'glibc-2.17-alt8.src.rpm',
                 vendor: 'ALT Linux Team',
                 distribution: 'ALT Linux',
                 # changelogname: changelogname,
                 # changelogtext: changelogtext,
                 # changelogtime: changelogtime,
                 md5: '8bad93ffb43f9486cd7e17eff1c19389',
                 builder_id: 25,
                 size: 11_417_028,
                 repocop: 'warn',
                 created_at: created_at,
                 updated_at: updated_at
    end

    subject { srpm.decorate.as_json }

    its([:id]) { should eq(336_994) }

    its([:branch_id]) { should eq(1) }

    its([:branch]) { should eq('Sisyphus') }

    its([:name]) { should eq('glibc') }

    its([:version]) { should eq('2.17') }

    its([:release]) { should eq('alt8') }

    its([:epoch]) { should eq(6) }

    its([:summary]) { should eq('The GNU libc libraries') }

    its([:license]) { should eq('LGPLv2+, LGPLv2+ with exceptions, GPLv2+') }

    its([:group]) { should eq('System/Base') }

    its([:group_id]) { should eq(1_083) }

    its([:url]) { should eq('http://www.gnu.org/software/glibc/') }

    its([:description]) { should eq('The GNU C library defines...') }

    its([:buildtime]) { should eq(buildtime) }

    its([:filename]) { should eq('glibc-2.17-alt8.src.rpm') }

    its([:vendor]) { should eq('ALT Linux Team') }

    its([:distribution]) { should eq('ALT Linux') }

    # changelogname: changelogname,
    # changelogtext: changelogtext,
    # changelogtime: changelogtime,

    its([:md5]) { should eq('8bad93ffb43f9486cd7e17eff1c19389') }

    its([:builder_id]) { should eq(25) }

    its([:size]) { should eq(11_417_028) }

    its([:repocop]) { should  eq('warn') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end

  describe '#short_url' do
    context 'url is present' do
      let(:url) { 'http://example.com' }

      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before { expect(subject).to receive(:create_link) }

      specify { expect { subject.short_url }.not_to raise_error }
    end

    context 'url is not present' do
      let(:srpm) { stub_model Srpm }

      subject { srpm.decorate }

      before { expect(subject).not_to receive(:create_link) }

      specify { expect(subject.short_url).to eq('&ndash;'.html_safe) }
    end
  end

  describe '#evr' do
    context 'epoch is present' do
      let(:srpm) do
        stub_model Srpm,
                   epoch: 20150928,
                   version: '1.0',
                   release: 'alt1'
      end

      subject { srpm.decorate }

      specify { expect(subject.evr).to eq('20150928:1.0-alt1') }
    end

    context 'epoch is not present' do
      let(:srpm) do
        stub_model Srpm,
                   version: '1.0',
                   release: 'alt1'
      end

      subject { srpm.decorate }

      specify { expect(subject.evr).to eq('1.0-alt1') }
    end
  end

  # private methods

  describe '#create_link' do
    context 'url length equal or more 27' do
      let(:url) { 'http://123456789012345678901234567890' }

      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before do
        #
        # subject.local_link_to("#{ url[0..26] }...")
        #
        expect(subject).to receive(:local_link_to).with("#{ url[0..26] }...")
      end

      specify { expect { subject.send(:create_link) }.not_to raise_error }
    end

    context 'url length less 27' do
      let(:url) { 'http://example.com' }

      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before do
        #
        # subject.local_link_to(url)
        #
        expect(subject).to receive(:local_link_to).with(url)
      end

      specify { expect { subject.send(:create_link) }.not_to raise_error }
    end
  end

  describe '#local_link_to' do
    let(:text) { 'something' }

    let(:url) { 'http://example.com' }

    let(:srpm) { stub_model Srpm, url: url }

    subject { srpm.decorate }

    before do
      #
      # subject.h.link_to(text, url, class: 'news', rel: 'nofollow')
      #
      expect(subject).to receive(:h) do
        double.tap do |a|
          expect(a).to receive(:link_to).with(text, url, class: 'news', rel: 'nofollow')
        end
      end
    end

    specify { expect { subject.send(:local_link_to, text) }.not_to raise_error }
  end
end
