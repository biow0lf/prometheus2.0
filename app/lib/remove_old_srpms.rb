class RemoveOldSrpms
  attr_reader :branch, :path

  def initialize(branch, path)
    @branch = branch
    @path = path
  end

  def perform
    branch.srpms.each do |srpm|
      srpm.destroy unless File.exist?("#{ path }#{ srpm.filename }")
    end
  end
end
