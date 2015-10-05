require 'rails_helper'

describe User do

  it { is_expected.to have_many(:companies) }
  it { is_expected.to have_many(:friends).dependent(true) }
  it { is_expected.to have_many(:reviews).dependent(true) }
  it { is_expected.to have_many(:votes).dependent(true) }
  it { is_expected.to have_many(:messages).dependent(true) }

end
