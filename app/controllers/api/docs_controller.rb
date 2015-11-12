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
      key :host, 'packages.altlinux.org'
      # key :host, 'localhost:3000'
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
      tag do
        key :name, 'packages'
        key :description, 'Packages operations'
      end
      tag do
        key :name, 'changelogs'
        key :description, 'Changelogs operations'
      end
    end

    swagger_path '/srpms/{name}' do
      operation :get do
        key :description, 'Returns srpm info for given name'
        key :operationId, 'findSrpmByName'
        key :tags, ['srpms']
        parameter do
          key :name, :name
          key :in, :path
          key :description, 'Srpm name'
          key :required, true
          key :type, :string
        end
        parameter do
          key :name, :branch_id
          key :in, :query
          key :description, 'Branch id. Default: Sisyphus branch id, not name. E.g. 1.'
          key :type, :integer
          key :format, :int64
        end
      end
    end

    swagger_path '/srpms/{name}/packages' do
      operation :get do
        key :description, 'Returns srpm packages info for given name'
        key :operationId, 'findPackagesForSrpm'
        key :tags, ['packages']
        parameter do
          key :name, :name
          key :in, :path
          key :description, 'Srpm name'
          key :required, true
          key :type, :string
        end
        parameter do
          key :name, :branch_id
          key :in, :query
          key :description, 'Branch id. Default: Sisyphus branch id, not name. E.g. 1.'
          key :type, :integer
          key :format, :int64
        end
      end
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
        Api::Docs::Branches,
        Api::Docs::Bugs,
        Api::Docs::Changelogs,
        Api::Docs::Maintainers,
        self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
