module Api
  class PackagesController < BaseController
    include Swagger::Blocks

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
          key :type, :integer
          key :format, :int64
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

    private

    def branch
      if params[:branch_id]
        @branch ||= Branch.find_by!(id: params[:branch_id])
      else
        @branch ||= Branch.find_by!(name: 'Sisyphus')
      end
    end

    def parent
      @srpm ||= branch.srpm.find_by!(name: params[:srpm_id])
    end

    def collection
      @packages ||= parent.packages
    end
  end
end
