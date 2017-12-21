# frozen_string_literal: true

require 'rails_helper'

describe SrpmsController do
  describe 'routing' do
    it 'should route /:branch/srpms/:id to srpms#show' do
      expect(get: '/Sisyphus/srpms/glibc').to route_to(
        controller: 'srpms',
        action: 'show',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id to srpms#show' do
      expect(get: '/en/Sisyphus/srpms/glibc').to route_to(
        controller: 'srpms',
        action: 'show',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end

    it 'should route /:branch/srpms/:id/changelog to srpms#show' do
      expect(get: '/Sisyphus/srpms/glibc/changelog').to route_to(
        controller: 'srpms',
        action: 'changelog',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/changelog to srpms#changelog' do
      expect(get: '/en/Sisyphus/srpms/glibc/changelog').to route_to(
        controller: 'srpms',
        action: 'changelog',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end

    it 'should route /:branch/srpms/:id/spec to srpms#spec' do
      expect(get: '/Sisyphus/srpms/glibc/spec').to route_to(
        controller: 'srpms',
        action: 'spec',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/spec to srpms#spec' do
      expect(get: '/en/Sisyphus/srpms/glibc/spec').to route_to(
        controller: 'srpms',
        action: 'spec',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end

    it 'should route /:branch/srpms/:id/rawspec to srpms#rawspec' do
      expect(get: '/Sisyphus/srpms/glibc/rawspec').to route_to(
        controller: 'srpms',
        action: 'rawspec',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/rawspec to srpms#rawspec' do
      expect(get: '/en/Sisyphus/srpms/glibc/rawspec').to route_to(
        controller: 'srpms',
        action: 'rawspec',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end

    it 'should route /:branch/srpms/:id/get to srpms#get' do
      expect(get: '/Sisyphus/srpms/glibc/get').to route_to(
        controller: 'srpms',
        action: 'get',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/get to srpms#get' do
      expect(get: '/en/Sisyphus/srpms/glibc/get').to route_to(
        controller: 'srpms',
        action: 'get',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end

    it 'should route /:branch/srpms/:id/gear to srpms#gear' do
      expect(get: '/Sisyphus/srpms/glibc/gear').to route_to(
        controller: 'srpms',
        action: 'gear',
        branch: 'Sisyphus',
        id: 'glibc'
      )
    end

    it 'should route /:locale/:branch/srpms/:id/gear to srpms#gear' do
      expect(get: '/en/Sisyphus/srpms/glibc/gear').to route_to(
        controller: 'srpms',
        action: 'gear',
        branch: 'Sisyphus',
        id: 'glibc',
        locale: 'en'
      )
    end
  end
end
