require 'rails_helper'

describe SrpmAllBugsController do
  describe 'routing' do
    it 'should route /Sisyphus/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/Sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc')
    end

    it 'should route /:locale/Sisyphus/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc',
        locale: 'en')
    end
  end
end
