class User < ActiveRecord::Base

  has_many :friends, dependent: :destroy
  has_many :companies
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :flags, foreign_key: :flaged_user_id, dependent: :destroy

  validates :role, presence: true

  validates :full_name, presence: true,
                        uniqueness: true

  has_secure_password

end
