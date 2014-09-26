class User < ActiveRecord::Base
  validates :email, immutable: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO: move this method to AltLinuxUser class
  def is_alt_team?
    if email.split('@').last == 'altlinux.org' ||
       email.split('@').last == 'altlinux.ru'
      true
    else
      false
    end
  end

  # TODO: move this method to AltLinuxUser class
  def login
    email.split('@').first
  end
end
