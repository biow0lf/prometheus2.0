require 'rails_helper'

describe BugsImport do
  # it 'should import bugs from given url' do
  #   page = File.read('spec/data/bugs.csv')
  #   url = 'https://bugzilla.altlinux.org/buglist.cgi?ctype=csv'
  #   FakeWeb.register_uri(:get, url, response: page)
  #
  #   bugs_import = BugsImport.new(url)
  #   expect { bugs_import.execute }.to change(Bug, :count).by(1)
  #
  #   bug = Bug.first
  #   expect(bug.bug_id).to eq(22_555)
  #   expect(bug.bug_status).to eq('CLOSED')
  #   expect(bug.resolution).to eq('FIXED')
  #   expect(bug.bug_severity).to eq('blocker')
  #   expect(bug.product).to eq('Sisyphus')
  #   expect(bug.component).to eq('openbox')
  #   expect(bug.assigned_to).to eq('icesik@altlinux.org')
  #   expect(bug.reporter).to eq('user@email.com')
  #   expect(bug.short_desc).to eq('segfault')
  # end

  # private methods

  describe '#uri' do
    let(:url) { double }

    subject { described_class.new(url) }

    before { expect(subject).to receive(:url).and_return(url) }

    before { expect(URI).to receive(:parse).with(url) }

    specify { expect { subject.send(:uri) }.not_to raise_error }
  end
end
