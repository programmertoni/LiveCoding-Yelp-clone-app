require 'rails_helper'

describe Flag do

  it { is_expected.to belong_to(:review) }

end
