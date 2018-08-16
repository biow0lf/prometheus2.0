# frozen_string_literal: true

require 'rails_helper'

describe MaintainersController do
  describe 'routing' do
    it 'should route /:branch/maintainers to maintainers#index' do
      expect(get: '/sisyphus/maintainers').to route_to(
        controller: 'maintainers',
        action: 'index',
        branch: 'sisyphus'
      )
    end

    it 'should route /:locale/:branch/maintainers to maintainers#index' do
      expect(get: '/en/sisyphus/maintainers').to route_to(
        controller: 'maintainers',
        action: 'index',
        branch: 'sisyphus',
        locale: 'en'
      )
    end

    it 'should route /:branch/maintainers/:id to maintainers#show' do
      expect(get: '/sisyphus/maintainers/icesik').to route_to(
        controller: 'maintainers',
        action: 'show',
        branch: 'sisyphus',
        id: 'icesik'
      )
    end

    it 'should route /:locale/:branch/maintainers/:id to maintainers#show' do
      expect(get: '/en/sisyphus/maintainers/icesik').to route_to(
        controller: 'maintainers',
        action: 'show',
        branch: 'sisyphus',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /:branch/maintainers/:id/srpms to maintainers#srpms' do
      expect(get: '/sisyphus/maintainers/icesik/srpms').to route_to(
        controller: 'maintainers',
        action: 'srpms',
        branch: 'sisyphus',
        id: 'icesik'
      )
    end

    it 'should route /:locale/:branch/maintainers/:id/srpms to maintainers#srpms' do
      expect(get: '/en/sisyphus/maintainers/icesik/srpms').to route_to(
        controller: 'maintainers',
        action: 'srpms',
        branch: 'sisyphus',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /sisyphus/maintainers/:id/gear to maintainers#gear' do
      expect(get: '/sisyphus/maintainers/icesik/gear').to route_to(
        controller: 'maintainers',
        action: 'gear',
        id: 'icesik'
      )
    end

    it 'should route /:locale/sisyphus/maintainers/:id/gear to maintainers#gear' do
      expect(get: '/en/sisyphus/maintainers/icesik/gear').to route_to(
        controller: 'maintainers',
        action: 'gear',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /sisyphus/maintainers/:id/bugs to maintainers#bugs' do
      expect(get: '/sisyphus/maintainers/icesik/bugs').to route_to(
        controller: 'maintainers',
        action: 'bugs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/sisyphus/maintainers/:id/bugs to maintainers#bugs' do
      expect(get: '/en/sisyphus/maintainers/icesik/bugs').to route_to(
        controller: 'maintainers',
        action: 'bugs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /sisyphus/maintainers/:id/allbugs to maintainers#allbugs' do
      expect(get: '/sisyphus/maintainers/icesik/allbugs').to route_to(
        controller: 'maintainers',
        action: 'allbugs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/sisyphus/maintainers/:id/allbugs to maintainers#allbugs' do
      expect(get: '/en/sisyphus/maintainers/icesik/allbugs').to route_to(
        controller: 'maintainers',
        action: 'allbugs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /sisyphus/maintainers/:id/ftbfs to maintainers#ftbfs' do
      expect(get: '/sisyphus/maintainers/icesik/ftbfs').to route_to(
        controller: 'maintainers',
        action: 'ftbfs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/sisyphus/maintainers/:id/ftbfs to maintainers#ftbfs' do
      expect(get: '/en/sisyphus/maintainers/icesik/ftbfs').to route_to(
        controller: 'maintainers',
        action: 'ftbfs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /sisyphus/maintainers/:id/repocop to maintainers#repocop' do
      expect(get: '/sisyphus/maintainers/icesik/repocop').to route_to(
        controller: 'maintainers',
        action: 'repocop',
        id: 'icesik'
      )
    end

    it 'should route /:locale/sisyphus/maintainers/:id/repocop to maintainers#repocop' do
      expect(get: '/en/sisyphus/maintainers/icesik/repocop').to route_to(
        controller: 'maintainers',
        action: 'repocop',
        id: 'icesik',
        locale: 'en'
      )
    end
  end
end
