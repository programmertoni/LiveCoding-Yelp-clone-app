class AddTimeStampsToMultipleTables < ActiveRecord::Migration
  def change
    add_column :categories, :created_at, :datetime
    add_column :categories, :updated_at, :datetime
    add_column :companies, :created_at, :datetime
    add_column :companies, :updated_at, :datetime
    add_column :flags, :created_at, :datetime
    add_column :flags, :updated_at, :datetime
    add_column :reviews, :created_at, :datetime
    add_column :reviews, :updated_at, :datetime
    add_column :votes, :created_at, :datetime
    add_column :votes, :updated_at, :datetime
  end
end
