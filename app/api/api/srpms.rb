module API
  class Srpms < Grape::API
    desc 'Get srpm info'
    params do
      requires :name, type: String, desc: 'Srpm name'
      optional :branch_id, type: Integer, desc: 'Branch id. Default: Sisyphus branch id.'
    end
    get ':srpm_name' do
      if params[:branch_id]
        branch = Branch.find_by!(id: params[:branch_id])
      else
        branch = Branch.find_by!(name: 'Sisyphus')
      end
      present branch.srpms.where(name: params[:name])
         .includes(:branch).first!, with: API::Entities::Srpm
    end
  end
end
