require 'rails_helper'

describe Api::PackageController do
  # private methods

  describe '#resource' do
    let(:params) { { id: 'openbox' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # subject.branch.packages.find_by!(name: params[:id])
      #
      expect(subject).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:packages) do
            double.tap do |b|
              expect(b).to receive(:find_by!).with(name: params[:id])
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end
end
