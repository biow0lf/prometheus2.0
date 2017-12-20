# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputSrpm
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputSrpm do
          key :required, [:id, :branch_id, :branch, :name, :version, :release,
                          :epoch, :summary, :license, :group, :group_id, :url,
                          :description, :buildtime, :filename, :vendor,
                          :distribution, :md5, :builder_id, :size, :repocop,
                          :created_at, :updated_at]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'Srpm ID'
          end
          property :branch_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Branch ID'
          end
          property :branch do
            key :type, :string
            key :description, 'Branch name'
          end
          property :name do
            key :type, :string
            key :description, 'Srpm name'
          end
          property :version do
            key :type, :string
            key :description, 'Srpm version'
          end
          property :release do
            key :type, :string
            key :description, 'Srpm release'
          end
          property :epoch do
            key :type, :integer
            key :format, :int64
            key :description, 'Srpm epoch'
          end
          property :summary do
            key :type, :string
            key :description, 'Srpm summary'
          end
          property :license do
            key :type, :string
            key :description, 'Srpm license'
          end
          property :group do
            key :type, :string
            key :description, 'Srpm group name'
          end
          property :group_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Srpm group id'
          end
          property :url do
            key :type, :string
            key :description, 'Srpm url'
          end
          property :description do
            key :type, :string
            key :description, 'Srpm description'
          end
          property :buildtime do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Buildtime in ISO8601 format'
          end
          property :filename do
            key :type, :string
            key :description, 'Srpm filename'
          end
          property :vendor do
            key :type, :string
            key :description, 'Srpm Vendor'
          end
          property :distribution do
            key :type, :string
            key :description, 'Srpm Distribution'
          end
          # TODO:
          # changelogname: changelogname,
          # changelogtext: changelogtext,
          # changelogtime: changelogtime,
          property :md5 do
            key :type, :string
            key :description, 'Srpm md5 sum'
          end
          property :builder_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Srpm builder id (maintainer id)'
          end
          property :size do
            key :type, :integer
            key :format, :int64
            key :description, 'Srpm size'
          end
          property :repocop do
            key :type, :string
            key :description, 'Repocop status'
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
        end
        # :nocov:
      end
    end
  end
end
