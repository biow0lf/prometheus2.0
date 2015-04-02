class FixMaintainerEmail
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def execute
    email.gsub!(' at ', '@')
    email.gsub!(' dot ', '.')
    email.gsub!('altlinux.ru', 'altlinux.org')
    email.gsub!('altlinux.net', 'altlinux.org')
    email.gsub!('altlinux.com', 'altlinux.org')
    email
  end
end
