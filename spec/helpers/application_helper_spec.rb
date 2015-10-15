require 'rails_helper'

describe ApplicationHelper do

  describe '#shorten_full_name' do
    it 'shortens last name to first cahracter' do
      full_name = 'Toni Cesarek'
      expect(shorten_full_name(full_name)).to eq('Toni C.')
    end
  end

  describe '#average_rating' do
    let(:user_1) { Fabricate(:user, role: 'owner') }
    let(:user_2) { Fabricate(:user, role: 'owner') }
    let(:company) { Fabricate(:company) }

    it 'returnes average rating for same company' do
      Fabricate(:review, company: company, stars: 3, user: user_1)
      Fabricate(:review, company: company, stars: 5, user: user_2)
      expect(average_rating(company)).to eq(4)
    end

    it 'returnes 0 if there is no reviews for the company' do
      expect(average_rating(company)).to eq(0)
    end
  end
end
