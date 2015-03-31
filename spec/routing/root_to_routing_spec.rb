require 'rails_helper'

describe 'root' do
  describe 'routing' do
    it 'routes to home#index' do
      expect(get: '/').to route_to('home#index')
    end
  end
end
