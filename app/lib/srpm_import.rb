class SrpmImport
  attr_reader :branch, :srpm, :rpm, :file

  def initialize(branch, srpm, rpm, file)
    @branch = branch
    @srpm = srpm
    @rpm = rpm
    @file = file
  end

  def execute
    srpm.branch_id = branch.id

    # TODO: add srpm.buildhost
    [:name, :version, :release, :epoch, :summary, :license, :url,
     :distribution, :vendor, :description, :buildtime,
     :changelogname, :changelogtext, :changelogtime, :md5, :size,
     :filename].each do |field|
      srpm.send("#{ field }=", rpm.send(field))
    end

    group_name = rpm.group
    Group.import(branch, group_name)
    group = Group.in_branch(branch, group_name)

    Maintainer.import(rpm.packager)

    srpm.group_id = group.id
    srpm.groupname = group_name

    # TODO: test for this
    # hack for very long summary in openmoko_dfu-util src.rpm
    srpm.summary = 'Broken' if srpm.name == 'openmoko_dfu-util'

    email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil

    if email
      email.downcase!
      email = FixMaintainerEmail.new(email).execute
      Maintainer.import_from_changelogname(rpm.changelogname)
      maintainer = Maintainer.where(email: email).first
      srpm.builder_id = maintainer.id
    end

    if srpm.save
      Redis.current.set("#{ branch.name }:#{ srpm.filename }", 1)
      # TODO: make it clear
      Changelog.import(file, srpm)
      Specfile.import(file, srpm)
      Patch.import(file, srpm)
      Source.import(file, srpm)
    else
      puts "#{ Time.now }: failed to update '#{ srpm.filename }'"
    end
  end
end
