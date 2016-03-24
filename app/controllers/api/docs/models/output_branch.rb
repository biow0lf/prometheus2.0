module Api
  module Docs
    module Models
      class OutputBranch
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputBranch do
          key :required, [:id, :name, :order_id, :path, :created_at,
                          :updated_at, :count]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'Branch ID. e.g. "1" for "Sisyphus"'
          end
          property :name do
            key :type, :string
            key :description, 'Branch name. e.g. "Sisyphus"'
          end
          property :order_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Branch sort order id'
          end
          property :path do
            key :type, :string
            key :description, 'Branch path'
          end
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Created at in ISO8601 format'
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Updated at in ISO8601 format'
          end
          property :count do
            key :type, :integer
            key :format, :int64
            key :description, 'Branch srpms count'
          end
        end
        # :nocov:
      end
    end
  end
end
