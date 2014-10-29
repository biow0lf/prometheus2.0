require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController, type: :routing do
  describe 'routing' do
    it 'should route / to home#index' do
      expect({ get: '/' }).to route_to(controller: 'home',
                                       action: 'index')
    end

    it 'should route /en to home#index' do
      expect({ get: '/en' }).to route_to(controller: 'home',
                                         action: 'index',
                                         locale: 'en')
    end

    it 'should route /en/Sisyphus/home to home#index' do
      expect({ get: '/en/Sisyphus/home' }).to route_to(controller: 'home',
                                                       action: 'index',
                                                       branch: 'Sisyphus',
                                                       locale: 'en')
    end

    it 'should route /Sisyphus/people to home#maintainers_list' do
      expect({ get: '/Sisyphus/people' }).to route_to(controller: 'home',
                                                      action: 'maintainers_list',
                                                      branch: 'Sisyphus')
    end

    it 'should route /en/Sisyphus/people to home#maintainers_list' do
      expect({ get: '/en/Sisyphus/people' }).to route_to(controller: 'home',
                                                         action: 'maintainers_list',
                                                         branch: 'Sisyphus',
                                                         locale: 'en')
    end
  end
end
