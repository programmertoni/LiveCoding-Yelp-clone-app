class User < ActiveRecord::Base

  has_many :companies
  has_many :friends,  dependent: :destroy
  has_many :reviews,  dependent: :destroy
  has_many :votes,    dependent: :destroy
  has_many :messages, dependent: :destroy

  validates  :full_name, presence: true
  validates  :role,
              presence: true,
              exclusion: { in: ['admin'] },
              on: [:create]

  has_secure_password

  def all_friends
    friends_ids = Friend.where(user_id: self.id, a_friend: true).pluck(:id_of_friend)
    User.where(id: friends_ids)
  end

  def pending_friends
    pending_friends_ids = Friend.where(user_id: self.id, pending: true).pluck(:id_of_friend)
    User.where(id: pending_friends_ids)
  end

  def blocked_friends
    blocked_friends_ids = Friend.where(user_id: self.id, user_blocked: true).pluck(:id_of_friend)
    User.where(id: blocked_friends_ids)
  end

  def num_of_friends
    all_friends.pluck(:id).count
  end

  def num_of_pending_friends
    pending_friends.pluck(:id).count
  end

  def num_of_blocked_friends
    blocked_friends.pluck(:id).count
  end

end
