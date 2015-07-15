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

  describe '#as_json'

  # private methods

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
