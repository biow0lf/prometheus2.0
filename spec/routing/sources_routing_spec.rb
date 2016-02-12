require 'rails_helper'

describe SourcesController do
  describe 'routing' do
    it 'should route /:branch/srpms/:srpm_id/sources to sources#index' do
      expect(get: '/Sisyphus/srpms/glibc/sources').to route_to(
        controller: 'sources',
        action: 'index',
        branch: 'Sisyphus',
        srpm_id: 'glibc')
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/sources to sources#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/sources').to route_to(
        controller: 'sources',
        action: 'index',
        branch: 'Sisyphus',
        srpm_id: 'glibc',
        locale: 'en')
    end
  end
end
