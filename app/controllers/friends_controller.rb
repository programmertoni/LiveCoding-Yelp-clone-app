class FriendsController < ApplicationController
  before_action :require_user

  def index
    users        = User.where.not(id: current_user.id)
    # this map iteration is gathering users that are not already friends
    @not_friends = users.map  do |user|
      current_user.friends.pluck(:id_of_friend).include?(user.id) ? nil : user
    end
    @not_friends.compact!
  end

  def search
    users        = User.where.not(id: current_user.id)
    # this map iteration is gathering users that are not already friends
    @not_friends = users.map  do |user|
      current_user.friends.pluck(:id_of_friend).include?(user.id) ? nil : user
    end
    @not_friends.compact!

    @search_term   = params[:name]
    @search_result = []

    @not_friends.each do |user|
      result = user.full_name.downcase.scan(@search_term.downcase)
      @search_result << user if result.any?
    end
  end

end
