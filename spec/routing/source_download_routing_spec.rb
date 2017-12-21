# frozen_string_literal: true

require 'rails_helper'

describe SourceDownloadController do
  describe 'routing' do
    it 'should route /:branch/srpms/:srpm_id/sources/:source_id/download to source_download#show' do
      expect(get: '/Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download').to route_to(
        controller: 'source_download',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'glibc',
        source_id: 'glibc-2.16-alt4.tar'
      )
    end

    it 'should route /:locale/:branch/srpms/:srpm_id/sources/:id/download to source_download#show' do
      expect(get: '/en/Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download').to route_to(
        controller: 'source_download',
        action: 'show',
        branch: 'Sisyphus',
        srpm_id: 'glibc',
        source_id: 'glibc-2.16-alt4.tar',
        locale: 'en'
      )
    end
  end
end
