require 'rails_helper'

describe PatchesController do
  describe 'routing' do
    it 'should route /:branch/srpms/:srpm_id/patches to patches#index' do
      expect(get: '/Sisyphus/srpms/glibc/patches').to route_to(
        controller: 'patches',
        action: 'index',
        branch: 'Sisyphus',
        srpm_id: 'glibc')
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/patches to patches#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/patches').to route_to(
        controller: 'patches',
        action: 'index',
        branch: 'Sisyphus',
        srpm_id: 'glibc',
        locale: 'en')
    end

    it 'should route /:branch/srpms/:srpm_id/patches/:id/download to patches#download' do
      expect(get: '/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download').to route_to(
        controller: 'patches',
        action: 'download',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        id: 'pmount-0.9.23-alt-natspec.patch')
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/patches/:id/download to patches#download' do
      expect(get: '/en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download').to route_to(
        controller: 'patches',
        action: 'download',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        id: 'pmount-0.9.23-alt-natspec.patch',
        locale: 'en')
    end

    it 'should route /:branch/srpms/:srpm_id/patches/:id to patches#show' do
      expect(get: '/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch').to route_to(
        controller: 'patches',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        id: 'pmount-0.9.23-alt-natspec.patch')
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/patches/:id to patches#show' do
      expect(get: '/en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch').to route_to(
        controller: 'patches',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        id: 'pmount-0.9.23-alt-natspec.patch',
        locale: 'en')
    end
  end
end
