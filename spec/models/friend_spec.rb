require 'rails_helper'

describe Friend do
  it { is_expected.to belong_to(:user) }
end
