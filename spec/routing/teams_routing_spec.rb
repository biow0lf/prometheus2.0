require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeamsController, type: :routing do
  describe 'routing' do
    it 'should route /Sisyphus/teams/ruby to teams#show' do
      expect(get: '/Sisyphus/teams/ruby').to route_to(controller: 'teams',
                                                      action: 'show',
                                                      branch: 'Sisyphus',
                                                      id: 'ruby')
    end

    it 'should route /en/Sisyphus/teams/ruby to teams#show' do
      expect(get: '/en/Sisyphus/teams/ruby').to route_to(controller: 'teams',
                                                         action: 'show',
                                                         branch: 'Sisyphus',
                                                         id: 'ruby',
                                                         locale: 'en')
    end
  end
end
