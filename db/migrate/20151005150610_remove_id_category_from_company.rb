class RemoveIdCategoryFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :id_for_category
  end
end
