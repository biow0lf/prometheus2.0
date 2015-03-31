require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe GroupController do
  describe 'routing' do
    it 'should route /:branch/packages to group#index' do
      expect(get: '/Sisyphus/packages').to route_to(
        controller: 'group',
        action: 'index',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/packages to group#index' do
      expect(get: '/en/Sisyphus/packages').to route_to(
        controller: 'group',
        action: 'index',
        locale: 'en',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:branch/packages/:group to group#bygroup' do
      expect(get: '/Sisyphus/packages/Accessibility').to route_to(
        controller: 'group',
        action: 'show',
        branch: 'Sisyphus',
        group: 'Accessibility'
      )
    end

    it 'should route /:locale/:branch/packages/:group to group#bygroup' do
      expect(get: '/en/Sisyphus/packages/Accessibility').to route_to(
        controller: 'group',
        action: 'show',
        locale: 'en',
        branch: 'Sisyphus',
        group: 'Accessibility'
      )
    end

    it 'should route /:branch/packages/:group/:group2 to group#bygroup' do
      expect(get: '/Sisyphus/packages/Archiving/Compression').to route_to(
        controller: 'group',
        action: 'show',
        branch: 'Sisyphus',
        group: 'Archiving',
        group2: 'Compression'
      )
    end

    it 'should route /:locale/:branch/packages/:group/:group2 to group#bygroup' do
      expect(get: '/en/Sisyphus/packages/Archiving/Compression').to route_to(
        controller: 'group',
        action: 'show',
        locale: 'en',
        branch: 'Sisyphus',
        group: 'Archiving',
        group2: 'Compression'
      )
    end

    it 'should route /:branch/packages/:group/:group2/:group3 to group#bygroup' do
      expect(get: '/Sisyphus/packages/System/Configuration/Hardware').to route_to(
        controller: 'group',
        action: 'show',
        branch: 'Sisyphus',
        group: 'System',
        group2: 'Configuration',
        group3: 'Hardware'
      )
    end

    it 'should route /:locale/:branch/packages/:group/:group2/:group3 to group#bygroup' do
      expect(get: '/en/Sisyphus/packages/System/Configuration/Hardware').to route_to(
        controller: 'group',
        action: 'show',
        locale: 'en',
        branch: 'Sisyphus',
        group: 'System',
        group2: 'Configuration',
        group3: 'Hardware'
      )
    end
  end
end
