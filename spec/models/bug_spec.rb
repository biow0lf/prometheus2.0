require 'rails_helper'

describe Bug do
  describe 'Validations' do
    it { should validate_presence_of(:bug_id) }
  end

  describe 'DB Indexes' do
    it { should have_db_index(:assigned_to) }

    it { should have_db_index(:bug_status) }

    it { should have_db_index(:product) }
  end

  describe '.opened_bugs_for' do
    before do
      #
      # components = ['anything']
      # bug_statuses = %w(NEW ASSIGNED VERIFIED REOPENED)
      # Bug.where(component: components, bug_status: bug_statuses).order(bug_id: :desc)
      #
      bug_statuses = %w(NEW ASSIGNED VERIFIED REOPENED)
      components = ['anything']

      expect(described_class).to receive(:where).with(component: components, bug_status: bug_statuses) do
        double.tap do |a|
          expect(a).to receive(:order).with(bug_id: :desc)
        end
      end
    end

    specify { expect { described_class.opened_bugs_for(['anything']) }.not_to raise_error }
  end

  describe '.all_bugs_for' do
    before do
      #
      # Bug.where(component: components).order(bug_id: :desc)
      #
      components = ['anything']
      expect(described_class).to receive(:where).with(component: components) do
        double.tap do |a|
          expect(a).to receive(:order).with(bug_id: :desc)
        end
      end
    end

    specify { expect { described_class.all_bugs_for(['anything']) }.not_to raise_error }
  end
end
