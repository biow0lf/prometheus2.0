require 'rails_helper'

describe Branch do
  it { should be_a(ApplicationRecord) }

  it { should be_a(Redis::Objects) }

  describe 'Associations' do
    it { should have_many(:srpms).dependent(:destroy) }

    it { should have_many(:changelogs).through(:srpms) }

    it { should have_many(:packages).through(:srpms) }

    it { should have_many(:groups).dependent(:destroy) }

    it { should have_many(:teams).dependent(:destroy) }

    it { should have_many(:mirrors).dependent(:destroy) }

    it { should have_many(:patches).through(:srpms) }

    it { should have_many(:sources).through(:srpms) }

    it { should have_many(:ftbfs).class_name('Ftbfs').dependent(:destroy) }

    it { should have_many(:repocops).dependent(:destroy) }

    it { should have_many(:repocop_patches).dependent(:destroy) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:vendor) }
  end

  describe '#counter' do
    subject { stub_model Branch, id: 42 }

    specify { expect(subject.counter).to be_a(Redis::Counter) }
  end

  describe 'Callbacks' do
    it { should callback(:set_default_counter_value).after(:create) }

    it { should callback(:destroy_counter).after(:destroy) }
  end

  describe '#to_param' do
    subject { stub_model Branch, name: 'Sisyphus' }

    its(:to_param) { should eq('Sisyphus') }
  end

  # private methods

  describe '#set_default_counter_value' do
    subject { stub_model Branch }

    before do
      #
      # subject.counter.value = 0
      #
      expect(subject).to receive(:counter) do
        double.tap do |a|
          expect(a).to receive(:value=).with(0)
        end
      end
    end

    specify { expect { subject.send(:set_default_counter_value) }.not_to raise_error }
  end

  describe '#destroy_counter' do
    subject { stub_model Branch, id: 14 }

    before do
      #
      # Redis.current.del("branch:#{ subject.id }:counter")
      #
      expect(Redis).to receive(:current) do
        double.tap do |a|
          expect(a).to receive(:del).with("branch:#{ subject.id }:counter")
        end
      end
    end

    specify { expect { subject.send(:destroy_counter) }.not_to raise_error }
  end
end
