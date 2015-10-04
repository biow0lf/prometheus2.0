require 'rails_helper'

describe SrpmDecorator do
  describe '#as_json' do

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
