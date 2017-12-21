# frozen_string_literal: true

require 'rails_helper'

describe SrpmRepocopsController do
  describe '#index' do
    before { get :index, params: { id: 'glibc', locale: 'en', format: :html } }

    pending { should render_template(:index) }

    pending { should respond_with(:ok) }
  end
end
