require 'rails_helper'

describe Review do

  it { is_expected.to belong_to(:user) }

end
