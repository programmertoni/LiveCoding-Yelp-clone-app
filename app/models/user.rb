class User < ActiveRecord::Base

  validates :full_name, presence: true,
                        uniqueness: true

  validates :role, presence: true

  has_secure_password

end
