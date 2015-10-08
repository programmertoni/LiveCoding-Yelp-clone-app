require 'rails_helper'

describe Category do

  it { is_expected.to have_many(:category_companies).dependent(true) }
  it { is_expected.to have_many(:companies).through(:category_companies) }

  it { is_expected.to validate_presence_of(:title) }

end
