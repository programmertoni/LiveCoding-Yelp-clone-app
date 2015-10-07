class Company < ActiveRecord::Base

  has_many   :reviews, dependent: :destroy
  has_many   :category_companies, dependent: :destroy
  has_many   :categories, through: :category_companies
  belongs_to :city
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  validates :name,        presence: true
  validates :price_range, presence: true

end
