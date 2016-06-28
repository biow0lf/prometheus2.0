require 'rails_helper'

describe Api::BugsController do
  describe '#show' do
    before { get :show, params: { id: '22555', format: :json } }

    it { should render_template(:show) }

    it { should respond_with(:ok) }
  end

  # private methods

  describe '#resource' do
    let(:params) { { id: '22555' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # Bug.find_by!(bug_id: params[:id])
      #
      expect(Bug).to receive(:find_by!).with(bug_id: params[:id])
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end
end
