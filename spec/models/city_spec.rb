require 'rails_helper'

describe City do

  it { is_expected.to have_many(:companies) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:country) }

end
