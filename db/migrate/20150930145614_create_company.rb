class CreateCompany < ActiveRecord::Migration

  def change

    create_table   :companies do |t|
      t.string     :name
      t.string     :address
      t.string     :city
      t.integer    :price_range, limit:  1
      t.references :category, index: true
      t.references :user, index: true
    end

    create_table :category do |t|
      t.string   :title
    end

    create_table   :reviews do |t|
      t.integer    :stars, limit: 1
      t.text       :content
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true
      t.references :company, index: true
    end

    create_table   :votes do |t|
      t.string     :type
      t.references :review, index: true
      t.references :user, index: true
    end

    create_table   :flags do |t|
      t.boolean    :flaged
      t.references :review, index: true
      t.integer    :flaged_user_id, index: true
      t.integer    :flaged_by_user_id, index: true
    end

  end

end
