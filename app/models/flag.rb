class Flag < ActiveRecord::Base

  belongs_to :user, foreign_key: :flaged_user_id
  belongs_to :flagger, foreign_key: :flaged_by_user_id
  belongs_to :review

end
