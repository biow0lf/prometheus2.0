class PackageDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    super only: [:id, :srpm_id, :name, :version, :release, :epoch, :arch, :summary, :license, :url, :description, :group_id, :md5,
                 :groupname, :sourcepackage, :size, :filename],
          methods: [:buildtime, :created_at, :updated_at]
  end

  private

  def buildtime
    model.buildtime.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end

  def created_at
    model.created_at.iso8601
  end
end
