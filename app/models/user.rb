# encoding: utf-8

class User < ActiveRecord::Base
  validates :email, immutable: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def is_alt_team?
    if email.split('@')[1] == 'altlinux.org' || email.split('@')[1] == 'altlinux.ru'
      true
    else
      false
    end
  end

  def login
    email.split('@')[0]
  end
end
