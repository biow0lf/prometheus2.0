module MaintainerHelper
  def fix_maintainer_email(email)
    email.gsub!(' at altlinux.ru', '@altlinux.org')
    email.gsub!(' at altlinux.org', '@altlinux.org')
    email.gsub!(' at altlinux.net', '@altlinux.org')
    email.gsub!(' at altlinux.com', '@altlinux.org')
    email.gsub!(' at altlinux dot org', '@altlinux.org')
    email.gsub!(' at altlinux dot ru', '@altlinux.org')
    email.gsub!(' at altlinux dot net', '@altlinux.org')
    email.gsub!(' at altlinux dot com', '@altlinux.org')
    email.gsub!('@altlinux.ru', '@altlinux.org')
    email.gsub!('@altlinux.net', '@altlinux.org')
    email.gsub!('@altlinux.com', '@altlinux.org')
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
