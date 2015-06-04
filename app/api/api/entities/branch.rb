module API
  module Entities
    class Branch < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Branch ID. e.g. "0"' }
      expose :name, documentation: { type: String, desc: 'Branch name. e.g. "Sisyphus"' }
      expose :vendor, documentation: { type: String, desc: 'Branch vendor. e.g. "ALT Linux"' }
      expose :order_id, documentation: { type: Integer, desc: 'Order id for branch sorting' }
      expose :path, documentation: { type: String, desc: 'Path' }
      expose :created_at, documentation: { type: 'DateTime', desc: 'Created at field' }
      expose :updated_at, documentation: { type: 'DateTime', desc: 'Updated at field' }
      expose :count do |model|
        model.srpms.count
      end
    end
  end
end
