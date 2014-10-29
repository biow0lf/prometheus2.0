require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MaintainerProfilesController, type: :routing do
  describe 'routing' do
    it 'should route /maintainer_profile/edit to maintainer_profiles#edit' do
      expect({ get: '/maintainer_profile/edit' }).to route_to(controller: 'maintainer_profiles',
                                                              action: 'edit')
    end

    it 'should route /en/maintainer_profile/edit to maintainer_profiles#edit' do
      expect({ get: '/en/maintainer_profile/edit' }).to route_to(controller: 'maintainer_profiles',
                                                                 action: 'edit',
                                                                 locale: 'en')
    end

    it 'should route PUT /maintainer_profile to maintainer_profiles#update' do
      expect({ put: '/maintainer_profile' }).to route_to(controller: 'maintainer_profiles',
                                                         action: 'update')
    end

    it 'should route PUT /en/maintainer_profile to maintainer_profiles#update' do
      expect({ put: '/en/maintainer_profile' }).to route_to(controller: 'maintainer_profiles',
                                                            action: 'update',
                                                            locale: 'en')
    end
  end
end
