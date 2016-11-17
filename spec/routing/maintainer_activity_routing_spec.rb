require 'rails_helper'

describe MaintainerActivityController do
  describe 'routing' do
    it 'should route /:branch/maintainers/:maintainer_id/activity to maintainer_activity#index' do
      expect(get: '/Sisyphus/maintainers/icesik/activity').to route_to(
        controller: 'maintainer_activity',
        action: 'index',
        branch: 'Sisyphus',
        maintainer_id: 'icesik'
      )
    end

    it 'should route /:locale/:branch/maintainers/:maintainer_id/activity to maintainer_activity#index' do
      expect(get: '/en/Sisyphus/maintainers/icesik/activity').to route_to(
        controller: 'maintainer_activity',
        action: 'index',
        branch: 'Sisyphus',
        maintainer_id: 'icesik',
        locale: 'en'
      )
    end
  end
end
