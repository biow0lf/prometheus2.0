require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe 'Teams routing' do
  it 'should route /:branch/teams/:id to teams#show' do
    expect(get: '/Sisyphus/teams/ruby').to route_to(
      controller: 'teams',
      action: 'show',
      branch: 'Sisyphus',
      id: 'ruby'
    )
  end

  it 'should route /:locale/:branch/teams/:id to teams#show' do
    expect(get: '/en/Sisyphus/teams/ruby').to route_to(
      controller: 'teams',
      action: 'show',
      branch: 'Sisyphus',
      id: 'ruby',
      locale: 'en'
    )
  end
end
