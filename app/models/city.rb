class City < ActiveRecord::Base

  has_many :companies

  validates :name,    presence: true
  validates :country, presence: true

  scope :list_all, -> { all.order(name: :asc) }

end
