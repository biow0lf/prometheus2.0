require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchesController, type: :routing do
  describe 'routing' do
    it 'should route /search?utf8=yes&branch=Sisyphus&query=openbox to searches#show' do
      expect({ get: '/search?utf8=yes&branch=Sisyphus&query=openbox' }).to route_to(controller: 'searches',
                                                                                    action: 'show',
                                                                                    utf8: 'yes',
                                                                                    branch: 'Sisyphus',
                                                                                    query: 'openbox')
    end

    it 'should route /en/search?utf8=yes&branch=Sisyphus&query=openbox to searches#show' do
      expect({ get: '/en/search?utf8=yes&branch=Sisyphus&query=openbox' }).to route_to(controller: 'searches',
                                                                                       action: 'show',
                                                                                       utf8: 'yes',
                                                                                       branch: 'Sisyphus',
                                                                                       query: 'openbox',
                                                                                       locale: 'en')
    end
  end
end
