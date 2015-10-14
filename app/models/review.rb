class Review < ActiveRecord::Base
  has_many   :flags, dependent: :destroy
  has_many   :votes, dependent: :destroy
  belongs_to :company
  belongs_to :user

  validates :stars,   presence: true
  validates :content, presence: true, 
                      length: { maximum: 500 }

  validates_uniqueness_of :user_id, scope: [:user_id, :company_id]

  def flaged_by?(user)
    Flag.where(review_id: self.id, flaged_by_user_id: user.id) == [] ? false : true
  end

  def voted_on_useful_vote_by?(current_user)
    Vote.where(review_id: self.id, user_id: current_user.id, vote_type: 'useful') == [] ? false : true
  end

  def voted_on_funny_vote_by?(current_user)
    Vote.where(review_id: self.id, user_id: current_user.id, vote_type: 'funny') == [] ? false : true
  end

  def voted_on_cool_vote_by?(current_user)
    Vote.where(review_id: self.id, user_id: current_user.id, vote_type: 'cool') == [] ? false : true
  end
end
