require 'rails_helper'

describe PackageObserver do
  subject { described_class.send(:new) }

  describe '#after_destroy' do
    let(:package) { stub_model Package, filename: 'openbox-1.0.i588.rpm' }

    before do
      #
      # package.srpm.branch.name => 'Sisyphus'
      #
      expect(package).to receive(:srpm) do
        double.tap do |a|
          expect(a).to receive(:branch) do
            double.tap do |b|
              expect(b).to receive(:name).and_return('Sisyphus')
            end
          end
        end
      end
    end

    before do
      #
      # Redis.current.del("#{ package.srpm.branch.name }:#{ package.filename }")
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:del).with('Sisyphus:openbox-1.0.i588.rpm')
        end
      end
    end

    specify { expect { subject.send(:after_destroy, package) }.not_to raise_error }
  end
end
