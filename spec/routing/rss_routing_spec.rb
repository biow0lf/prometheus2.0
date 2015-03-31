require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe RssController do
  describe 'routing' do
    it 'should route /:branch/rss to rss#index' do
      expect(get: '/Sisyphus/rss').to route_to(
        controller: 'rss',
        action: 'index',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/rss to rss#index' do
      expect(get: '/en/Sisyphus/rss').to route_to(
        controller: 'rss',
        action: 'index',
        branch: 'Sisyphus',
        locale: 'en'
      )
    end
  end
end
