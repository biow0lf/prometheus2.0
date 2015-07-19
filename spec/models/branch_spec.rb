require 'rails_helper'

describe Branch do
  context 'Associations' do
    it { should have_many :srpms }

    it { should have_many(:changelogs).through(:srpms) }

    it { should have_many(:packages).through(:srpms) }

    it { should have_many :groups }

    it { should have_many :teams }

    it { should have_many :mirrors }

    it { should have_many(:patches).through(:srpms) }

    it { should have_many(:sources).through(:srpms) }

    it { should have_many(:ftbfs).class_name('Ftbfs') }

    it { should have_many :repocops }

    it { should have_many :repocop_patches }
  end

  context 'Validation' do
    it { should validate_presence_of :name }

    it { should validate_presence_of :vendor }
  end

  describe 'after_destroy' do
    subject { stub_model Branch }

    before { expect(subject).to receive(:destroy_counter) }

    specify { expect { subject.destroy! }.not_to raise_error }
  end

  describe '#to_param' do
    subject { stub_model Branch, name: 'Sisyphus' }

    specify { expect(subject.to_param).to eq('Sisyphus') }
  end

  describe '#recount!' do
    subject { stub_model Branch }

    before { subject.counter.value = 42 }

    specify { expect { subject.recount! }.to change { subject.counter.value }.from(42).to(0) }
  end

  describe '#destroy_counter' do
    subject { stub_model Branch, id: 77 }

    before { subject.counter.value = 15 }

    specify do
      expect { subject.destroy! }
        .to change { Redis.current.get("branch:#{ subject.id }:counter") }
        .from('15').to(nil)
    end
  end
end
