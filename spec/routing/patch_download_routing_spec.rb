require 'rails_helper'

describe PatchDownloadController do
  describe 'routing' do
    it 'should route /:branch/srpms/:srpm_id/patches/:patch_id/download to patch_download#show' do
      expect(get: '/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download').to route_to(
        controller: 'patch_download',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        patch_id: 'pmount-0.9.23-alt-natspec.patch')
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/patches/:patch_id/download to patch_download#show' do
      expect(get: '/en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download').to route_to(
        controller: 'patch_download',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'pmount',
        patch_id: 'pmount-0.9.23-alt-natspec.patch',
        locale: 'en')
    end
  end
end
