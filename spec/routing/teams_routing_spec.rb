# frozen_string_literal: true

require 'rails_helper'

describe TeamsController do
  describe 'routing' do
    it 'should route /:branch/teams to teams#index' do
      expect(get: '/Sisyphus/teams').to route_to(
        controller: 'teams',
        action: 'index',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/:branch/teams to teams#index' do
      expect(get: '/en/Sisyphus/teams').to route_to(
        controller: 'teams',
        action: 'index',
        branch: 'Sisyphus',
        locale: 'en'
      )
    end

    it 'should route /:branch/teams/:id to teams#show' do
      expect(get: '/Sisyphus/teams/ruby').to route_to(
        controller: 'teams',
        action: 'show',
        branch: 'Sisyphus',
        id: 'ruby'
      )
    end

    it 'should route /:locale/:branch/teams/:id to teams#show' do
      expect(get: '/en/Sisyphus/teams/ruby').to route_to(
        controller: 'teams',
        action: 'show',
        branch: 'Sisyphus',
        id: 'ruby',
        locale: 'en'
      )
    end
  end
end
