require 'rails_helper'

describe Company do

  it { is_expected.to have_many(:reviews).dependent(true) }
  it { is_expected.to have_many(:category_companies).dependent(true) }
  it { is_expected.to have_many(:categories).through(:category_companies) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:owner) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price_range) }
  it { is_expected.to validate_presence_of(:city_id) }

end
