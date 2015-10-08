class RenameFriendsId < ActiveRecord::Migration
  def change
    rename_column :friends, :friend_id, :id_of_friend
  end
end
