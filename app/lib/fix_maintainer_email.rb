# frozen_string_literal: true

class FixMaintainerEmail
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def execute
    return unless email

    @email = email.downcase.gsub(' at ', '@')
                           .gsub(' dot ', '.')
                           .gsub(/altlinux\.(ru|net|com)/, 'altlinux.org')
  end
end
