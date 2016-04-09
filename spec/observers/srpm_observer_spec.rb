require 'rails_helper'

describe SrpmObserver do
  subject { described_class.send(:new) }

  describe '#after_create' do
    let(:srpm) { double }

    before { expect(subject).to receive(:increment_branch_counter).with(srpm) }

    before { expect(subject).to receive(:add_filename_to_cache).with(srpm) }

    specify { expect { subject.send(:after_create, srpm) }.not_to raise_error }
  end

  describe '#after_destroy' do
    let(:srpm) { double }

    before { expect(subject).to receive(:decrement_branch_counter).with(srpm) }

    before { expect(subject).to receive(:remove_filename_from_cache).with(srpm) }

    specify { expect { subject.send(:after_destroy, srpm) }.not_to raise_error }
  end

  # private methods

  describe '#increment_branch_counter' do
    let(:srpm) { stub_model Srpm }

    before do
      #
      # srpm.branch.counter.increment
      #
      expect(srpm).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:counter) do
            double.tap do |b|
              expect(b).to receive(:increment)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:increment_branch_counter, srpm) }.not_to raise_error }
  end

  describe '#decrement_branch_counter' do
    let(:srpm) { stub_model Srpm }

    before do
      #
      # srpm.branch.counter.decrement
      #
      expect(srpm).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:counter) do
            double.tap do |b|
              expect(b).to receive(:decrement)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:decrement_branch_counter, srpm) }.not_to raise_error }
  end

  describe '#add_filename_to_cache' do
    let(:srpm) { stub_model Srpm, filename: 'openbox-1.0.src.rpm' }

    let(:branch) { stub_model Branch, name: 'Sisyphus' }

    before { expect(srpm).to receive(:branch).and_return(branch) }

    before do
      #
      # Redis.current.set("#{ srpm.branch.name }:#{ srpm.filename }", 1)
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:set).with('Sisyphus:openbox-1.0.src.rpm', 1)
        end
      end
    end

    specify { expect { subject.send(:add_filename_to_cache, srpm) }.not_to raise_error }
  end


  describe '#remove_filename_from_cache' do
    let(:srpm) { stub_model Srpm, filename: 'openbox-1.0.src.rpm' }

    let(:branch) { stub_model Branch, name: 'Sisyphus' }

    before { expect(srpm).to receive(:branch).and_return(branch) }

    before do
      #
      # Redis.current.del("#{ srpm.branch.name }:#{ srpm.filename }")
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:del).with('Sisyphus:openbox-1.0.src.rpm')
        end
      end
    end

    specify { expect { subject.send(:remove_filename_from_cache, srpm) }.not_to raise_error }
  end
end
