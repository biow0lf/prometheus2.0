require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SecurityController, type: :routing do
  describe 'routing' do
    it 'should route /en/Sisyphus/security to security#index' do
      expect({ get: '/en/Sisyphus/security' }).to route_to(controller: 'security',
                                                           action: 'index',
                                                           branch: 'Sisyphus',
                                                           locale: 'en')
    end

    it 'should route /Sisyphus/security to security#index' do
      expect({ get: '/Sisyphus/security' }).to route_to(controller: 'security',
                                                        action: 'index',
                                                        branch: 'Sisyphus')
    end

    it 'should route /en/Sisyphus/security?page=2 to security#index' do
      expect({ get: '/en/Sisyphus/security?page=2' }).to route_to(controller: 'security',
                                                                  action: 'index',
                                                                  locale: 'en',
                                                                  branch: 'Sisyphus',
                                                                  page: '2')
    end

    it 'should route /Sisyphus/security?page=2 to security#index' do
      expect({ get: '/Sisyphus/security?page=2' }).to route_to(controller: 'security',
                                                               action: 'index',
                                                               branch: 'Sisyphus',
                                                               page: '2')
    end
  end
end
