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
      key :schemes, %w(https http)
      key :host, 'packages.altlinux.org'
      # key :host, 'localhost:3000'
      key :basePath, '/api'
      key :consumes, ['application/json']
      key :produces, ['application/json']
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
      tag do
        key :name, 'packages'
        key :description, 'Packages operations'
      end
      tag do
        key :name, 'changelogs'
        key :description, 'Changelogs operations'
      end
      tag do
        key :name, 'maintainers'
        key :description, 'Maintainers operations'
      end
      tag do
        key :name, 'package'
        key :description, 'Package operation'
      end
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
        Api::Docs::Models::OutputBranch,
        Api::Docs::Models::OutputBug,
        Api::Docs::Models::OutputChangelog,
        Api::Docs::Models::OutputPackage,
        Api::Docs::Models::OutputSrpm,

        Api::Docs::Branches,
        Api::Docs::Bugs,
        Api::Docs::Changelogs,
        Api::Docs::Maintainers,
        Api::Docs::Packages,
        Api::Docs::Srpms,
        Api::Docs::Package,
        self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
