# frozen_string_literal: true

require 'rails_helper'

describe RsyncController do
  describe 'routing' do
    it 'should route /rsync/new to rsync#new' do
      expect(get: '/rsync/new').to route_to('rsync#new')
    end

    it 'should route /:locale/rsync/new to rsync#new' do
      expect(get: '/en/rsync/new').to route_to(
        controller: 'rsync',
        action: 'new',
        locale: 'en'
      )
    end
  end
end
