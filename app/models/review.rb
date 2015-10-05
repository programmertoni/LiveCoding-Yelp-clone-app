class Review < ActiveRecord::Base

  has_many :flags, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :company

  validate :type, presence: true

end
