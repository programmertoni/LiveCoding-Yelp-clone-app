class User < ActiveRecord::Base

  has_many :companies
  has_many :friends
  has_many :reviews
  has_many :votes
  has_many :messages

end
