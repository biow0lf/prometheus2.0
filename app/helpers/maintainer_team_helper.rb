# encoding: utf-8

module MaintainerTeamHelper
  def fix_maintainer_email(email)
    email.gsub!('ruby at packages.altlinux.org', 'ruby@packages.altlinux.org')
    email.gsub!('ruby at packages.altlinux.ru', 'ruby@packages.altlinux.org')
    email.gsub!('ruby at packages.altlinux.net', 'ruby@packages.altlinux.org')
    email.gsub!('ruby at packages.altlinux.com', 'ruby@packages.altlinux.org')
    email.gsub!('ruby@packages.altlinux.ru', 'ruby@packages.altlinux.org')
    email.gsub!('ruby@packages.altlinux.net', 'ruby@packages.altlinux.org')
    email.gsub!('ruby@packages.altlinux.com', 'ruby@packages.altlinux.org')
    email
  end
end
