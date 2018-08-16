# frozen_string_literal: true

require 'rails_helper'

describe SrpmRepocopsController do
  describe 'routing' do
    it 'should route /sisyphus/srpms/:id/repocop to srpm_repocops#index' do
      expect(get: '/sisyphus/srpms/glibc/repocop').to route_to(
        controller: 'srpm_repocops',
        action: 'index',
        id: 'glibc',
        branch: 'sisyphus'
      )
    end

    it 'should route /:locale/sisyphus/srpms/:id/repocop to srpm_repocops#index' do
      expect(get: '/en/sisyphus/srpms/glibc/repocop').to route_to(
        controller: 'srpm_repocops',
        action: 'index',
        id: 'glibc',
        locale: 'en',
        branch: 'sisyphus'
      )
    end
  end
end
