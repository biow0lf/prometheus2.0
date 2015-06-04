module API
  class Branches < Grape::API
    desc 'Get all branches'
    get '/' do
      present Branch.order('id ASC'), with: API::Entities::Branch
    end
  end
end
