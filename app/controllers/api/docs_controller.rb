module Api
  class DocsController < ActionController::Base
    include Swagger::Blocks

    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'Prometheus 2.0 API documentation'
        key :description, 'Prometheus 2.0 API documentation.'
      end
      key :schemes, ['http']
      # key :host, 'packages.altlinux.org'
      key :host, 'localhost:3000'
      key :basePath, '/api'
      key :consumes, %w(application/json)
      key :produces, %w(application/json)
      tag do
        key :name, 'branches'
        key :description, 'Branches operations'
      end
      tag do
        key :name, 'bugs'
        key :description, 'Bugs operations'
      end
      tag do
        key :name, 'srpms'
        key :description, 'Srpms operations'
      end
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
        Api::BugsController,
        self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
