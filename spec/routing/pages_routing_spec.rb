# frozen_string_literal: true

require 'rails_helper'

describe PagesController do
  describe 'routing' do
    it 'should route /project to pages#project' do
      expect(get: '/project').to route_to('pages#project')
    end

    it 'should route /:locale/project to pages#project' do
      expect(get: '/en/project').to route_to(
        controller: 'pages',
        action: 'project',
        locale: 'en'
      )
    end
  end
end
