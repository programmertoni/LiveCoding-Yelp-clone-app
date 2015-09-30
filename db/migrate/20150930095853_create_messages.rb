class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string   :title
      t.string   :content
      t.boolean  :message_read, default: false
      t.boolean  :important, default: false
      t.integer  :user_id
      t.integer  :friend_id
      t.timestamps
    end
  end
end
