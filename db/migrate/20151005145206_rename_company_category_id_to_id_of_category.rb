class RenameCompanyCategoryIdToIdOfCategory < ActiveRecord::Migration
  def change
    rename_column :companies, :category_id, :id_for_category
  end
end
