class User < ApplicationRecord
  has_secure_password

  has_many :games, dependent: :destroy
  validates_presence_of :name, :username, :password_digest
end
