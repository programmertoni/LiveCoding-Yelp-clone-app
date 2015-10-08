require 'rails_helper'

describe ApplicationHelper do

  describe '#shorten_full_name' do
    it 'shortens last name to first cahracter' do
      full_name = 'Toni Cesarek'
      expect(shorten_full_name(full_name)).to eq('Toni C.')
    end
  end


end
