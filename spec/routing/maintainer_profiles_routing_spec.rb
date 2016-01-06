require 'rails_helper'

describe MaintainerProfilesController do
  describe 'routing' do
    it 'should route /maintainer_profile/edit to maintainer_profiles#edit' do
      expect(get: '/maintainer_profile/edit').to route_to(
        controller: 'maintainer_profiles',
        action: 'edit')
    end

    it 'should route /:locale/maintainer_profile/edit to maintainer_profiles#edit' do
      expect(get: '/en/maintainer_profile/edit').to route_to(
        controller: 'maintainer_profiles',
        action: 'edit',
        locale: 'en')
    end

    it 'should route PUT /maintainer_profile to maintainer_profiles#update' do
      expect(put: '/maintainer_profile').to route_to(
        controller: 'maintainer_profiles',
        action: 'update')
    end

    it 'should route PUT /:locale/maintainer_profile to maintainer_profiles#update' do
      expect(put: '/en/maintainer_profile').to route_to(
        controller: 'maintainer_profiles',
        action: 'update',
        locale: 'en')
    end

    it 'should route PATCH /maintainer_profile to maintainer_profiles#update' do
      expect(patch: '/maintainer_profile').to route_to(
        controller: 'maintainer_profiles',
        action: 'update')
    end

    it 'should route PATCH /:locale/maintainer_profile to maintainer_profiles#update' do
      expect(patch: '/en/maintainer_profile').to route_to(
        controller: 'maintainer_profiles',
        action: 'update',
        locale: 'en')
    end
  end
end
