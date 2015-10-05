class User < ActiveRecord::Base

  has_many :companies
  has_many :friends,  dependent: :destroy
  has_many :reviews,  dependent: :destroy
  has_many :votes,    dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :full_name, presence: true
  validates :role,      presence: true

  has_secure_password

end
