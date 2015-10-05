class Review < ActiveRecord::Base

  has_many   :flags, dependent: :destroy
  has_many   :votes, dependent: :destroy
  belongs_to :company
  belongs_to :user

end
