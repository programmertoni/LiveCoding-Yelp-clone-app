class Review < ActiveRecord::Base
  has_many   :flags, dependent: :destroy
  has_many   :votes, dependent: :destroy
  belongs_to :company
  belongs_to :user

  validates :stars,   presence: true
  validates :content, presence: true, 
                      length: { maximum: 500 }

  validates_uniqueness_of :user_id, scope: [:user_id, :company_id]

end
