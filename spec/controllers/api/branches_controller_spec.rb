require 'rails_helper'

describe Api::BranchesController do
  describe '#index' do
    before { get :index, params: { format: :json } }

    it { should render_template(:index) }

    it { should respond_with(:ok) }
  end

  describe '#show' do
    before { get :show, params: { id: '42', format: :json } }

    it { should render_template(:show) }

    it { should respond_with(:ok) }
  end

  # private methods

  describe '#resource' do
    let(:params) { { id: '42' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # Branch.find(params[:id])
      #
      expect(Branch).to receive(:find).with(params[:id])
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end

  describe '#collection' do
    before do
      #
      # Branch.order(:order_id)
      #
      expect(Branch).to receive(:order).with(:order_id)
    end

    specify { expect { subject.send(:collection) }.not_to raise_error }
  end
end
