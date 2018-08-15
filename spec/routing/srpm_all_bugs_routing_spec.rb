# frozen_string_literal: true

require 'rails_helper'

describe SrpmAllBugsController do
  describe 'routing' do
    it 'should route /:branch/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/Sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc',
        locale: 'en',
        branch: 'Sisyphus'
      )
    end
  end
end
