require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RssController, type: :routing do
  describe 'routing' do
    it 'should route /Sisyphus/rss to rss#index' do
      expect({ get: '/Sisyphus/rss' }).to route_to(controller: 'rss',
                                                   action: 'index',
                                                   branch: 'Sisyphus')
    end

    it 'should route /en/Sisyphus/rss to rss#index' do
      expect({ get: '/en/Sisyphus/rss' }).to route_to(controller: 'rss',
                                                      action: 'index',
                                                      branch: 'Sisyphus',
                                                      locale: 'en')
    end
  end
end