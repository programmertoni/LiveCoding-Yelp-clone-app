require 'rails_helper'

describe Company do

  it { is_expected.to belong_to(:owner) }

end
