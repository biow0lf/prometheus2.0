module API
  class Branches < Grape::API
    # use Rack::JSONP

    desc 'Get all branches'

    get 'all' do
      present Branch.order('id ASC'), with: API::Entities::Branch
    end

  end
end
