# frozen_string_literal: true

require 'rails_helper'

describe SrpmAllBugsController do
  describe 'routing' do
    it 'should route /:branch/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc',
        branch: 'sisyphus'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/allbugs to srpm_all_bugs#index' do
      expect(get: '/en/sisyphus/srpms/glibc/allbugs').to route_to(
        controller: 'srpm_all_bugs',
        action: 'index',
        id: 'glibc',
        locale: 'en',
        branch: 'sisyphus'
      )
    end
  end
end
