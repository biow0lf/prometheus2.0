module API
  class Bugs < Grape::API
    desc 'Get bug info'
    params do
      requires :bug_id, type: Integer, desc: 'Bug id from bugzilla.altlinux.org'
    end
    get ':bug_id' do
      present Bug.find_by!(bug_id: params[:bug_id]), with: API::Entities::Bug
    end
  end
end
