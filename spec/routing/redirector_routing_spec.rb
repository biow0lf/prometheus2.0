require 'rails_helper'

describe RedirectorController do
  describe 'routing' do
    it 'should route /:name to redirector#index' do
      expect(get: '/glibc').to route_to(
        controller: 'redirector',
        action: 'index',
        name: 'glibc'
      )
    end
  end
end
