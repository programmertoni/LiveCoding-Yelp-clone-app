require 'rails_helper'

describe Vote do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:review) }
end
