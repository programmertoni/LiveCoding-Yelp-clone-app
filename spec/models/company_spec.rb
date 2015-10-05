require 'rails_helper'

describe Company do

  it { is_expected.to have_many(:categories) }
  # it { is_expected.to have_many(:reviews) }
  # it { is_expected.to belong_to(:user) }
  #
  # it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to validate_presence_of(:address) }
  # it { is_expected.to validate_presence_of(:city) }
  # it { is_expected.to validate_numericality_of(:price_range).only_integer }

end
