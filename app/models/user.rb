class User < ActiveRecord::Base
  validates :email, immutable: true
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_alt_team?
    if email.split('@')[1] == 'altlinux.org' ||
       email.split('@')[1] == 'altlinux.ru'
      true
    end
  end

  def login
    email.split('@')[0]
  end
end
