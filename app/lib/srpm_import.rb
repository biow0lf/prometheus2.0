class SrpmImport
  attr_reader :branch, :srpm, :rpm

  def initialize(branch, srpm, rpm)
    @branch = branch
    @srpm = srpm
    @rpm = rpm
  end

  def import
    # [:name, :version, :release, :epoch, :summary, :group, :license, :url,
    #  :packager, :vendor, :distribution, :description, :buildhost, :buildtime,
    #  :changelogname, :changelogtext, :changelogtime, :md5, :size,
    #  :filename].each do |field|
    #   srpm.send("#{ field }=", rpm.send(field))
    # end

    [:name, :version, :release, :epoch, :summary, :license, :url,
     :distribution, :description, :buildtime,
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

    srpm.buildtime = Time.at(rpm.buildtime.to_i)
    srpm.changelogtime = Time.at(rpm.changelogtime.to_i)

    changelogname = rpm.changelogname
    srpm.changelogname = changelogname

    srpm.changelogtext = rpm.changelogtext

    email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil

    if email
      email.downcase!
      email = FixMaintainerEmail.new(email).execute
      Maintainer.import_from_changelogname(changelogname)
      maintainer = Maintainer.where(email: email).first
      srpm.builder_id = maintainer.id
    end

    if srpm.save
      # Changelog.import(file, srpm)
      # Specfile.import(file, srpm)
      # Patch.import(file, srpm)
      # Source.import(file, srpm)
    else
      puts "#{ Time.now }: failed to update '#{ srpm.filename }'"
    end
  end
end
