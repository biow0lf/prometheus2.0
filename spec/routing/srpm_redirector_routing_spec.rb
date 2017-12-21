# frozen_string_literal: true

require 'rails_helper'

describe SrpmRedirectorController do
  describe 'routing' do
    it 'should route /src:name to srpm_redirector#index' do
      expect(get: '/src:glibc').to route_to(
        controller: 'srpm_redirector',
        action: 'index',
        name: 'glibc'
      )
    end
  end
end
