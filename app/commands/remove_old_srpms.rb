class RemoveOldSrpms < Rectify::Command
  attr_reader :branch, :path

  def initialize(branch, path)
    @branch = branch
    @path = path
  end

  def call
    branch.srpms.each do |srpm|
      srpm.destroy unless File.exist?("#{ path }#{ srpm.filename }")
    end

    broadcast(:ok)
  end
end
