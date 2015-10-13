class Company < ActiveRecord::Base

  has_many   :reviews, dependent: :destroy
  has_many   :category_companies, dependent: :destroy
  has_many   :categories, through: :category_companies
  belongs_to :city
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  validates :name,        presence: true
  validates :price_range, presence: true
  validates :city_id,     presence: true

  def self.search(name, city_id, category_id)
    case
    when city_id.empty? && category_id.empty?
      where('name LIKE(?)', "%#{name.downcase}%")
    when city_id.empty? && !category_id.empty?
      joins(:categories).where('name LIKE(?) AND category_id = ?', "%#{name.downcase}%", category_id)
    when !city_id.empty? && category_id.empty?
      where('name LIKE(?) AND city_id = ?', "%#{name.downcase}%", city_id)
    else
      joins(:categories).where('name LIKE(?) AND city_id = ? AND category_id = ?', "%#{name.downcase}%", city_id, category_id)
    end
  end

end
