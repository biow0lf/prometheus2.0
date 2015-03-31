require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe SecurityController do
  describe 'routing' do
    it 'should route /:locale/:branch/security to security#index' do
      expect(get: '/en/Sisyphus/security').to route_to(
        controller: 'security',
        action: 'index',
        branch: 'Sisyphus',
        locale: 'en'
      )
    end

    it 'should route /:branch/security to security#index' do
      expect(get: '/Sisyphus/security').to route_to(
        controller: 'security',
        action: 'index',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/security?page=:page to security#index' do
      expect(get: '/en/Sisyphus/security?page=2').to route_to(
        controller: 'security',
        action: 'index',
        locale: 'en',
        branch: 'Sisyphus',
        page: '2'
      )
    end

    it 'should route /:branch/security?page=:page to security#index' do
      expect(get: '/Sisyphus/security?page=2').to route_to(
        controller: 'security',
        action: 'index',
        branch: 'Sisyphus',
        page: '2'
      )
    end
  end
end
