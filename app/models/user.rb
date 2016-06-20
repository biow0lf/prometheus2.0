class User < ApplicationRecord
  validates :email, immutable: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def member?
    host = email.split('@').last
    if host == 'altlinux.org' || host == 'altlinux.ru'
      true
    else
      false
    end
  end

  def login
    email.split('@').first
  end
end
