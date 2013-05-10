class User < ActiveRecord::Base
  validates :email, immutable: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email#, :password, :password_confirmation,
#                  :confirmed_at

  def is_alt_team?
    if email.split('@')[1] == 'altlinux.org' ||
       email.split('@')[1] == 'altlinux.ru'
      true
    else
      false
    end
  end

  def login
    email.split('@')[0]
  end
end
