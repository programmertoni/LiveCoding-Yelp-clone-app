require 'rails_helper'

describe CategoriesController do

  describe '#show' do
    let!(:user)    { Fabricate(:user) }
    let!(:category)   { Fabricate(:category, title: 'Hotel') }
    let!(:company_1) { Fabricate(:company) }
    let!(:company_2) { Fabricate(:company) }

    before(:example) do
      company_1.categories << category
      company_2.categories << category
    end

    it 'assigns @companies for all Companies that have same category' do
      get :show, id: category.id
      expect(assigns[:companies]).to match_array([company_1, company_2])
    end
  end

end
