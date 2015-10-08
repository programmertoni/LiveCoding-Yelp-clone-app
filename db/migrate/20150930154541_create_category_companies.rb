class CreateCategoryCompanies < ActiveRecord::Migration
  def change
    create_table :category_companies do |t|
      t.integer  :category_id
      t.integer  :company_id
    end
    add_index :category_companies, :company_id
    add_index :category_companies, :category_id
  end
end
