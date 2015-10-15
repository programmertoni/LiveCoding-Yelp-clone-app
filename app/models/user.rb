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

  def unread_messages
    Message.where(user_id: self.id, message_read: false)
  end

  def num_of_unread_messages
    unread_messages.pluck(:id).count
  end

  def read_messages
    Message.where(user_id: self.id, message_read: true, important: false)
  end

  def num_of_read_messages
    read_messages.pluck(:id).count
  end

  def important_messages
    Message.where(user_id: self.id, message_read: true, important: true)
  end

  def num_of_important_messages
    important_messages.pluck(:id).count
  end

  def blocked_by?(friend)
    return Friend.where(user_blocked: true, user_id: friend.id, id_of_friend: self.id).any?
  end

end
