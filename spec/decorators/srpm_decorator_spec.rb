require 'rails_helper'

describe SrpmDecorator do
  describe '#short_url' do
    context 'url not set' do
      let(:srpm) { stub_model Srpm }

      subject { srpm.decorate }

      before { expect(subject).not_to receive(:create_link) }

      specify { expect(subject.short_url).to eq('&ndash;') }
    end

    context 'url is set' do
      let(:url) { 'http://example.com' }
      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before { expect(subject).to receive(:create_link).with(url) }

      specify { expect { subject.short_url }.not_to raise_error }
    end
  end

  describe '#evr' do
    context 'epoch not set' do
      let(:srpm) { stub_model Srpm, version: '1.0', release: 'alt1', epoch: nil }

      subject { srpm.decorate }

      specify { expect(subject.evr).to eq('1.0-alt1') }
    end

    context 'epoch is set' do
      let(:srpm) { stub_model Srpm, version: '1.0', release: 'alt1', epoch: 20150715 }

      subject { srpm.decorate }

      specify { expect(subject.evr).to eq('20150715:1.0-alt1') }
    end
  end

  describe '#as_json' do
    let(:branch) { stub_model Branch, id: 1, name: 'Sisyphus' }
    let(:buildtime) { Time.zone.now }
    let(:created_at) { Time.zone.now }
    let(:updated_at) { Time.zone.now }

    let(:srpm) do
      stub_model Srpm,
        id: 42,
        branch_id: 1,
        branch: branch,
        name: 'openbox',
        version: '4.0',
        release: 'alt1',
        epoch: 20150715,
        summary: 'Some summary',
        license: 'MIT',
        groupname: 'Base',
        group_id: 13,
        url: 'http://example.com',
        description: 'Some description',
        buildtime: buildtime,
        filename: 'openbox-4.0-alt1.src.rpm',
        vendor: 'ALT Linux',
        distribution: 'ALT Linux Team',
        # changelogname: changelogname,
        # changelogtext: changelogtext,
        # changelogtime: changelogtime,
        md5: 'f87ff0eaa4e16b202539738483cd54d1',
        builder_id: 123,
        size: 12_345,
        repocop: 'skip',
        created_at: created_at,
        updated_at: updated_at
    end

    subject { srpm.decorate.as_json }

    its([:id]) { should eq(42) }

    its([:branch_id]) { should eq(1) }

    its([:branch]) { should eq('Sisyphus') }

    its([:name]) { should eq('openbox') }

    its([:version]) { should eq('4.0') }

    its([:release]) { should eq('alt1') }

    its([:epoch]) { should eq(20150715) }

    its([:summary]) { should eq('Some summary') }

    its([:license]) { should eq('MIT') }

    its([:group]) { should eq('Base') }

    its([:group_id]) { should eq(13) }

    its([:url]) { should eq('http://example.com') }

    its([:description]) { should eq('Some description') }

    its([:buildtime]) { should eq buildtime.iso8601 }

    its([:filename]) { should eq('openbox-4.0-alt1.src.rpm') }

    its([:vendor]) { should eq('ALT Linux') }

    its([:distribution]) { should eq('ALT Linux Team') }

    # changelogname: changelogname,
    # changelogtext: changelogtext,
    # changelogtime: changelogtime,

    its([:md5]) { should eq 'f87ff0eaa4e16b202539738483cd54d1' }

    its([:builder_id]) { should eq 123 }

    its([:size]) { should eq 12_345 }

    its([:repocop]) { should eq 'skip' }

    its([:created_at]) { should eq created_at.iso8601 }

    its([:updated_at]) { should eq updated_at.iso8601 }
  end

  describe '#create_link' do
    context 'url length more 27' do
      let(:url) { '123456789012345678901234567890' }
      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before do
        expect(subject).to receive(:link_to_with_nofollow)
          .with("#{ url[0..26] }...", url)
      end

      specify { expect { subject.send(:create_link, url) }.not_to raise_error }
    end

    context 'url length is less 27' do
      let(:url) { '1234567890' }
      let(:srpm) { stub_model Srpm, url: url }

      subject { srpm.decorate }

      before do
        expect(subject).to receive(:link_to_with_nofollow).with(url, url)
      end

      specify { expect { subject.send(:create_link, url) }.not_to raise_error }
    end
  end

  describe '#link_to_with_nofollow' do
    let(:text) { 'some text' }
    let(:url) { 'http://example.com' }
    let(:srpm) { stub_model Srpm, url: url }

    subject { srpm.decorate }

    before do
      expect(subject).to receive(:h) do
        double.tap do |a|
          expect(a).to receive(:link_to).with(text, url, class: 'news', rel: 'nofollow')
        end
      end
    end

    specify { expect { subject.send(:link_to_with_nofollow, text, url) }.not_to raise_error }
  end
end
