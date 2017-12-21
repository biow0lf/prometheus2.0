# frozen_string_literal: true

require 'rails_helper'

describe SrpmRepocopsController do
  describe 'routing' do
    it 'should route /Sisyphus/srpms/:id/repocop to srpm_repocops#index' do
      expect(get: '/Sisyphus/srpms/glibc/repocop').to route_to(
        controller: 'srpm_repocops',
        action: 'index',
        id: 'glibc'
      )
    end

    it 'should route /:locale/Sisyphus/srpms/:id/repocop to srpm_repocops#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/repocop').to route_to(
        controller: 'srpm_repocops',
        action: 'index',
        id: 'glibc',
        locale: 'en'
      )
    end
  end
end
