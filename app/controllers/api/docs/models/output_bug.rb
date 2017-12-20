# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputBug
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputBug do
          key :required, [:bug_id, :bug_status, :resolution, :bug_severity,
                          :product, :component, :assigned_to, :reporter,
                          :short_desc, :created_at, :updated_at]
          property :bug_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Bug ID from bugzilla.altlinux.org'
          end
          property :bug_status do
            key :type, :string
            key :description, 'Bug status'
          end
          property :resolution do
            key :type, :string
            key :description, 'Bug resolution'
          end
          property :bug_severity do
            key :type, :string
            key :description, 'Bug severity'
          end
          property :product do
            key :type, :string
            key :description, 'Bug product'
          end
          property :component do
            key :type, :string
            key :description, 'Bug component'
          end
          property :assigned_to do
            key :type, :string
            key :description, 'Bug assigned to'
          end
          property :reporter do
            key :type, :string
            key :description, 'Bug reporter'
          end
          property :short_desc do
            key :type, :string
            key :description, 'Bug short description'
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
