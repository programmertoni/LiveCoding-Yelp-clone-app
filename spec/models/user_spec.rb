require 'rails_helper'

describe User do

  it { is_expected.to have_many(:companies) }
  it { is_expected.to have_many(:friends) }
  it { is_expected.to have_many(:reviews) }
  # testiraj če dela v rails conosole
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:messages) }

end
