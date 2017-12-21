# frozen_string_literal: true

require 'rails_helper'

describe MiscController do
  describe 'routing' do
    it 'should route /misc/bugs to misc#bugs' do
      expect(get: '/misc/bugs').to route_to('misc#bugs')
    end

    it 'should route /:locale/misc/bugs to misc#bugs' do
      expect(get: '/en/misc/bugs').to route_to(
        controller: 'misc',
        action: 'bugs',
        locale: 'en'
      )
    end
  end
end
