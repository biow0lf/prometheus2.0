# frozen_string_literal: true

require 'rails_helper'

describe MaintainersController do
  describe 'routing' do
    it 'should route /:branch/maintainers to maintainers#index' do
      expect(get: '/Sisyphus/maintainers').to route_to(
        controller: 'maintainers',
        action: 'index',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/maintainers to maintainers#index' do
      expect(get: '/en/Sisyphus/maintainers').to route_to(
        controller: 'maintainers',
        action: 'index',
        branch: 'Sisyphus',
        locale: 'en'
      )
    end

    it 'should route /:branch/maintainers/:id to maintainers#show' do
      expect(get: '/Sisyphus/maintainers/icesik').to route_to(
        controller: 'maintainers',
        action: 'show',
        branch: 'Sisyphus',
        id: 'icesik'
      )
    end

    it 'should route /:locale/:branch/maintainers/:id to maintainers#show' do
      expect(get: '/en/Sisyphus/maintainers/icesik').to route_to(
        controller: 'maintainers',
        action: 'show',
        branch: 'Sisyphus',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /:branch/maintainers/:id/srpms to maintainers#srpms' do
      expect(get: '/Sisyphus/maintainers/icesik/srpms').to route_to(
        controller: 'maintainers',
        action: 'srpms',
        branch: 'Sisyphus',
        id: 'icesik'
      )
    end

    it 'should route /:locale/:branch/maintainers/:id/srpms to maintainers#srpms' do
      expect(get: '/en/Sisyphus/maintainers/icesik/srpms').to route_to(
        controller: 'maintainers',
        action: 'srpms',
        branch: 'Sisyphus',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /Sisyphus/maintainers/:id/gear to maintainers#gear' do
      expect(get: '/Sisyphus/maintainers/icesik/gear').to route_to(
        controller: 'maintainers',
        action: 'gear',
        id: 'icesik'
      )
    end

    it 'should route /:locale/Sisyphus/maintainers/:id/gear to maintainers#gear' do
      expect(get: '/en/Sisyphus/maintainers/icesik/gear').to route_to(
        controller: 'maintainers',
        action: 'gear',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /Sisyphus/maintainers/:id/bugs to maintainers#bugs' do
      expect(get: '/Sisyphus/maintainers/icesik/bugs').to route_to(
        controller: 'maintainers',
        action: 'bugs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/Sisyphus/maintainers/:id/bugs to maintainers#bugs' do
      expect(get: '/en/Sisyphus/maintainers/icesik/bugs').to route_to(
        controller: 'maintainers',
        action: 'bugs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /Sisyphus/maintainers/:id/allbugs to maintainers#allbugs' do
      expect(get: '/Sisyphus/maintainers/icesik/allbugs').to route_to(
        controller: 'maintainers',
        action: 'allbugs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/Sisyphus/maintainers/:id/allbugs to maintainers#allbugs' do
      expect(get: '/en/Sisyphus/maintainers/icesik/allbugs').to route_to(
        controller: 'maintainers',
        action: 'allbugs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /Sisyphus/maintainers/:id/ftbfs to maintainers#ftbfs' do
      expect(get: '/Sisyphus/maintainers/icesik/ftbfs').to route_to(
        controller: 'maintainers',
        action: 'ftbfs',
        id: 'icesik'
      )
    end

    it 'should route /:locale/Sisyphus/maintainers/:id/ftbfs to maintainers#ftbfs' do
      expect(get: '/en/Sisyphus/maintainers/icesik/ftbfs').to route_to(
        controller: 'maintainers',
        action: 'ftbfs',
        id: 'icesik',
        locale: 'en'
      )
    end

    it 'should route /Sisyphus/maintainers/:id/repocop to maintainers#repocop' do
      expect(get: '/Sisyphus/maintainers/icesik/repocop').to route_to(
        controller: 'maintainers',
        action: 'repocop',
        id: 'icesik'
      )
    end

    it 'should route /:locale/Sisyphus/maintainers/:id/repocop to maintainers#repocop' do
      expect(get: '/en/Sisyphus/maintainers/icesik/repocop').to route_to(
        controller: 'maintainers',
        action: 'repocop',
        id: 'icesik',
        locale: 'en'
      )
    end
  end
end
