class User < ActiveRecord::Base

  has_many :friends

  validates :role, presence: true

  validates :full_name, presence: true,
                        uniqueness: true

  has_secure_password

end
