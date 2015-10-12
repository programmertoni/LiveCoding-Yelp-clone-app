class Category < ActiveRecord::Base

  has_many :category_companies, dependent: :destroy
  has_many :companies, through: :category_companies

  validates :title, presence: true

  scope :list_all, -> { all.order(title: :asc) }

end
