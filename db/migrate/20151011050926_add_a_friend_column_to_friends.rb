class AddAFriendColumnToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :a_friend, :boolean, default: false
  end
end
