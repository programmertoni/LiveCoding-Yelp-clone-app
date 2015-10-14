require 'rails_helper'

describe Company do

  it { is_expected.to have_many(:reviews).dependent(true) }
  it { is_expected.to have_many(:category_companies).dependent(true) }
  it { is_expected.to have_many(:categories).through(:category_companies) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:owner) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price_range) }
  it { is_expected.to validate_presence_of(:city_id) }

  describe '#search' do
    let!(:city_1)     { Fabricate(:city) }
    let!(:city_2)     { Fabricate(:city) }
    let!(:category_1) { Fabricate(:category) }
    let!(:category_2) { Fabricate(:category) }
    let!(:company_1)  { Fabricate(:company, name: 'Nike', city_id: city_1.id) }
    let!(:company_2)  { Fabricate(:company, name: 'Addidas', city_id: city_2.id) }
    let!(:company_3)  { Fabricate(:company, name: 'Amidas', city_id: city_1.id) }

    before(:example) do
      company_1.categories << category_1
      company_2.categories << category_1
      company_2.categories << category_2
    end

    it 'returns a company if user writes down the whole company name' do
      companies = Company.search('Addidas', '', '')
      expect(companies).to eq([company_2])
    end

  end

end
