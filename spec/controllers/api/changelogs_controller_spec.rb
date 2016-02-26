require 'rails_helper'

describe Api::ChangelogsController do
  describe '#index' do
    before { get :index, srpm_id: 'gcc', format: :json }

    it { should render_template(:index) }

    it { should respond_with(:ok) }
  end

  # private methods

  describe '#parent' do
    let(:params) { { srpm_id: 'gcc' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      #
      # subject.branch.srpms.find_by!(name: params[:srpm_id])
      #
      expect(subject).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:srpms) do
            double.tap do |b|
              expect(b).to receive(:find_by!).with(name: params[:srpm_id])
            end
          end
        end
      end
    end

    specify { expect { subject.send(:parent) }.not_to raise_error }
  end

  describe '#collection' do
    before do
      #
      # subject.parent.changelogs
      #
      expect(subject).to receive(:parent) do
        double.tap do |a|
          expect(a).to receive(:changelogs)
        end
      end
    end

    specify { expect { subject.send(:collection) }.not_to raise_error }
  end
end
