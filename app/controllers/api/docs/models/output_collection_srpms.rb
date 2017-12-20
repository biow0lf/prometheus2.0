# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputCollectionSrpms
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCollectionSrpms do
          key :required, [:collection, :total_pages, :current_page]
          property :collection do
            key :type, :array
            items do
              key :'$ref', :OutputSrpm
            end
          end
          property :total_pages do
            key :type, :integer
            key :format, :int64
            key :description, 'Total pages counter'
          end
          property :current_page do
            key :type, :integer
            key :format, :int64
            key :description, 'Current page number'
          end
        end
      end
    end
  end
end
