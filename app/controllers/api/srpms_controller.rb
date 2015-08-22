module Api
  class SrpmsController < BaseController
    include Swagger::Blocks

    swagger_path '/srpms/{name}.json' do
      operation :get do
        key :description, 'Returns srpm info for given name'
        key :operationId, 'findSrpmByName'
        key :tags, ['srpms']
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
          key :description, 'Branch id. Default: Sisyphus branch id.'
          key :type, :integer
          key :format, :int64
        end
      end
    end

    private

    def parent
      if params[:branch_id]
        @branch ||= Branch.find_by!(id: params[:branch_id])
      else
        @branch ||= Branch.find_by!(name: 'Sisyphus')
      end
    end

    def resource
      @srpm ||= parent.srpms.where(name: params[:id]).includes(:branch).first!
    end
  end
end
