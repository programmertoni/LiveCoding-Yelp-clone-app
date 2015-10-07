class CreateCities < ActiveRecord::Migration

  def up
    create_table :cities do |t|
      t.string :name
      t.string :country
      t.timestamps
    end

    remove_column :companies, :address
    remove_column :companies, :city
    add_column    :companies, :city_id, :integer
  end

  def down
    drop_table    :cities
    add_column    :companies, :address, :string
    add_column    :companies, :city,    :string
    remove_column :companies, :city_id
  end

end
