require 'grape'

module API
  class Base < Grape::API
    default_format :json

    mount API::Branches => '/branches'
    mount API::Bugs => '/bugs'
    mount API::Srpms => '/srpms'

    add_swagger_documentation(
        base_path: '/api',
        hide_documentation_path: true
    )
  end
end
