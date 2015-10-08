require 'rails_helper'

describe Review do

  it { is_expected.to have_many(:flags).dependent(true) }
  it { is_expected.to have_many(:votes).dependent(true) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:stars) }
  it { is_expected.to validate_presence_of(:content) }

end
