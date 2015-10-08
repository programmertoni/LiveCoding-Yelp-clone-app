class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, unique: true
      t.string :password_digest
      t.string :role
      t.timestamps
    end
  end
end
