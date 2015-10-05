require 'rails_helper'

describe CategoryCompany do

  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:company) }

end
