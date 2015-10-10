class AddUniquenessToReview < ActiveRecord::Migration
  def change
    add_index :reviews, [:user_id, :company_id], unique: true
  end
end
