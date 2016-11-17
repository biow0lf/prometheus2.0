require 'rails_helper'

describe SearchesController do
  describe 'routing' do
    it 'should route /search?utf8=yes&branch=:branch&query=:query to searches#show' do
      expect(get: '/search?utf8=yes&branch=Sisyphus&query=openbox').to route_to(
        controller: 'searches',
        action: 'show',
        utf8: 'yes',
        branch: 'Sisyphus',
        query: 'openbox'
      )
    end

    it 'should route /:locale/search?utf8=yes&branch=:branch&query=:query to searches#show' do
      expect(get: '/en/search?utf8=yes&branch=Sisyphus&query=openbox').to route_to(
        controller: 'searches',
        action: 'show',
        utf8: 'yes',
        branch: 'Sisyphus',
        query: 'openbox',
        locale: 'en'
      )
    end
  end
end
