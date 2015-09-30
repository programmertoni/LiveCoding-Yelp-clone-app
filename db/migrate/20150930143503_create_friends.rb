class CreateFriends < ActiveRecord::Migration
  def change
    create_table   :friends do |t|
      t.boolean    :pending
      t.boolean    :user_blocked
      t.references :user, index: true, foreign_key: true
      t.integer    :friend_id, index: true
      t.timestamps
    end
  end
end
