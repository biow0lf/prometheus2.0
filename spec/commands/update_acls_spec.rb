require 'rails_helper'

describe UpdateAcls do
  let(:branch) { double }

  subject { described_class.new(branch) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch) { should eq(branch) }
  end

  describe '#call' do
    context 'branch acls_url is empty' do
      let(:branch) { stub_model Branch }

      before { expect(Redis).not_to receive(:current) }

      before { expect(subject).not_to receive(:remove_branch_maintainers_acls) }

      before { expect(subject).not_to receive(:update_acls) }

      before { expect(subject).not_to receive(:broadcast) }

      specify { expect { subject.call }.not_to raise_error }
    end

    context 'branch acls_urls is present' do
      let(:branch) { stub_model Branch, acls_url: 'http://example.org/something' }

      before do
        #
        # Redis.current.multi
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:multi)
          end
        end
      end

      before do
        #
        # subject.remove_branch_maintainers_acls
        #
        expect(subject).to receive(:remove_branch_maintainers_acls)
      end

      before do
        #
        # subject.update_acls
        #
        expect(subject).to receive(:update_acls)
      end

      before do
        #
        # Redis.current.exec
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:exec)
          end
        end
      end

      before do
        #
        # subject.broadcast(:ok)
        #
        expect(subject).to receive(:broadcast).with(:ok)
      end

      specify { expect { subject.call }.not_to raise_error }
    end
  end

  # private methods

  describe '#file' do
    let(:branch) { stub_model Branch, acls_url: 'http://example.org/something' }

    let(:uri) { double }

    before do
      #
      # URI.escape(branch.acls_url) => uri
      #
      expect(URI).to receive(:escape).with(branch.acls_url).and_return(uri)
    end

    before do
      #
      # open(uri).read
      #
      expect(subject).to receive(:open).with(uri) do
        double.tap do |a|
          expect(a).to receive(:read)
        end
      end
    end

    specify { expect { subject.send(:file) }.not_to raise_error }
  end

  describe '#extract_package_name' do
    let(:line) { double }

    before do
      #
      # line.split("\t").first
      #
      expect(line).to receive(:split).with("\t") do
        double.tap do |a|
          expect(a).to receive(:first)
        end
      end
    end

    specify { expect { subject.send(:extract_package_name, line) }.not_to raise_error }
  end

  describe '#logins' do
    let(:line) { double }

    before do
      #
      # line.split("\n").last.split(' ')
      #
      expect(line).to receive(:split).with("\n") do
        double.tap do |a|
          expect(a).to receive(:last) do
            double.tap do |b|
              expect(b).to receive(:split).with(' ')
            end
          end
        end
      end
    end

    specify { expect { subject.send(:logins, line) }.not_to raise_error }
  end

  describe '#remove_branch_maintainers_acls' do
    let(:branch) { stub_model Branch, name: 'Sisyphus' }

    let(:login) { 'icesik' }

    before do
      #
      # Maintainer.pluck('login') => [login]
      #
      expect(Maintainer).to receive(:pluck).with('login').and_return([login])
    end

    before do
      #
      # Redis.current.del("#{ branch.name }:maintainers:#{ login }")
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:del).with("#{ branch.name }:maintainers:#{ login }")
        end
      end
    end

    specify { expect { subject.send(:remove_branch_maintainers_acls) }.not_to raise_error }
  end

  describe '#update_acls' do
    let(:file) { double }

    let(:line) { double }

    let(:package) { double }

    let(:login) { double }

    before { expect(subject).to receive(:file).and_return(file) }

    before do
      #
      # file.split("\n") => [line]
      #
      expect(file).to receive(:split).with("\n").and_return([line])
    end

    before do
      #
      # subject.extract_package_name(line) => package
      #
      expect(subject).to receive(:extract_package_name).with(line).and_return(package)
    end

    before { expect(subject).to receive(:remove_acls).with(package) }

    before do
      #
      # subject.logins(line) => [login]
      #
      expect(subject).to receive(:logins).with(line).and_return([login])
    end

    before do
      #
      # subject.add_acl(package, login)
      #
      expect(subject).to receive(:add_acl).with(package, login)
    end

    specify { expect { subject.send(:update_acls) }.not_to raise_error }
  end

  describe '#remove_acls' do
    let(:branch) { stub_model Branch, name: 'Sisyphus' }

    let(:package) { 'openbox' }

    before do
      #
      # Redis.current.del("#{ branch.name }:#{ package }:acls")
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:del).with("#{ branch.name }:#{ package }:acls")
        end
      end
    end

    specify { expect { subject.send(:remove_acls, package) }.not_to raise_error }
  end

  describe '#add_acl' do
    let(:branch) { stub_model Branch, name: 'Sisyphus' }

    let(:package) { 'openbox' }

    let(:login) { 'icesik' }

    before do
      #
      # Redis.current.sadd("#{ branch.name }:#{ package }:acls", login)
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:sadd).with("#{ branch.name }:#{ package }:acls", login)
        end
      end
    end

    before do
      #
      # Redis.current.sadd("#{ branch.name }:maintainers:#{ login }", package)
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:sadd).with("#{ branch.name }:maintainers:#{ login }", package)
        end
      end
    end

    specify { expect { subject.send(:add_acl, package, login) }.not_to raise_error }
  end
end
