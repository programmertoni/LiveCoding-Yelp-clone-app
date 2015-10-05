class Company < ActiveRecord::Base

  has_many   :category_companies, dependent: :destory
  has_many   :categories, through: :category_companies
  belongs_to :review
  belongs_to :user

  validate :name, presence: true
  validate :address, presence: true
  validate :city, presence: true
  validate :price_range,  presence: true,
                          numericality: { only_integer: true }

end
