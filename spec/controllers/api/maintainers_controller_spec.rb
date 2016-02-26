require 'rails_helper'

describe Api::MaintainersController do
  describe '#index' do
    before { get :index, format: :json }

    it { should render_template(:index) }

    it { should respond_with(:ok) }
  end

  describe '#show' do
    before { get :show, id: 42, format: :json }

    it { should render_template(:show) }

    it { should respond_with(:ok) }
  end

  # private methods

  describe '#resource' do
    let(:params) { { id: '42' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # Maintainer.find_by!(login: params[:id])
      #
      expect(Maintainer).to receive(:find_by!).with(login: params[:id])
    end

    specify { expect { subject.send(:resource) }.not_to raise_error }
  end

  describe '#collection' do
    before do
      #
      # Maintainer.order(:login)
      #
      expect(Maintainer).to receive(:order).with(:login)
    end

    specify { expect { subject.send(:collection) }.not_to raise_error }
  end
end
