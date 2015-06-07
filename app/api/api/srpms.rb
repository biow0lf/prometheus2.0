module API
  class Srpms < Grape::API
    desc 'Get srpm info'
    params do
      requires :srpm_name, type: String, desc: 'Bug id from bugzilla.altlinux.org.'
      optional :branch_id, type: Integer, desc: 'Branch id. Default: Sisyphus branch id.'
    end
    get ':srpm_name' do
      present Srpm.find_by!(name: params[:srpm_name]), with: API::Entities::Srpm
    end
  end
end
