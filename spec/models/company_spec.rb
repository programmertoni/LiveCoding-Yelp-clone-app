require 'rails_helper'

describe Company do

  it { is_expected.to have_many(:reviews).dependent(true) }
  it { is_expected.to have_many(:category_companies).dependent(true) }
  it { is_expected.to have_many(:categories).through(:category_companies) }
  it { is_expected.to belong_to(:owner) }

end
