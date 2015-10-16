require 'rails_helper'

describe CompaniesController do

  describe 'GET #new' do
    context 'when owner is logged in' do
      let(:owner) { Fabricate(:user, role: 'owner') }

      it 'assigns @company' do
        session[:user_id] = owner.id
        get :new, user_id: owner.id
        expect(assigns[:company]).to be_a_new(Company)
      end
    end

    context 'when user is not loged in' do
      let(:user) { Fabricate(:user, role: 'user') }

      it 'redirects to login path' do
        get :new, user_id: user.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when owner is logged in' do
      let(:owner) { Fabricate(:user, role: 'owner') }
      let(:user)  { Fabricate(:user, role: 'user') }

      context 'with valid params' do
        before(:example) do
          session[:user_id] = owner.id
        end

        it 'creates new company' do
          post :create,
                user_id: owner.id,
                company: Fabricate.attributes_for(:company)

          expect(Company.all.count).to eq(1)
          expect(flash[:success]).to eq("You've just created new company!")
        end
      end
    end

    context 'when user is logged in' do
      let(:user)  { Fabricate(:user, role: 'user') }

      before(:example) do
        session[:user_id] = user.id
      end

      it 'does not create company' do
        post :create,
              user_id: user.id,
              company: Fabricate.attributes_for(:company)

        expect(Company.all.count).to eq(0)
      end

      it 'redirects_to root_path' do
        post :create, user_id: user.id,
              company: Fabricate.attributes_for(:company)

        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq("You have to be logged in!")
      end
    end

    context 'when visitor is not logged in' do
      let(:user) { Fabricate(:user, role: 'user') }

      it 'redirects to login_path' do
        post :create, user_id: user.id,
              company: Fabricate.attributes_for(:company)

        expect(response).to redirect_to(login_path)
      end

    end

  end

  describe 'GET #index' do
    context 'when owner is logged in' do
      let!(:owner)     { Fabricate(:user, role: 'owner') }
      let!(:company)   { Fabricate(:company, 
                                    name: 'Zelot Factory',
                                    user_id: owner.id) }
      let!(:company_1) { Fabricate(:company,
                                    name: 'Arived Transport',
                                    user_id: owner.id) }

      before(:example) do
        session[:user_id] = owner.id
      end

      it 'assigns @companies' do
        get :index, user_id: owner.id
        expect(assigns[:companies]).to match_array([company, company_1])
      end

      it 'sorts @companies from a-z' do
        get :index, user_id: owner.id
        expect(assigns[:companies]).to eq([company_1, company])
      end

    end

    context 'when owner is not loged in' do
      let(:owner) { Fabricate(:user, role: 'owner') }

      it 'redirects to login_path' do
        get :index, user_id: owner.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #show' do
      let!(:owner)     { Fabricate(:user, role: 'owner') }
      let!(:company)   { Fabricate(:company, 
                                    name: 'Zelot Factory',
                                    user_id: owner.id) }
    it 'assigns @company' do
      session[:user_id] = owner.id
      get :show, user_id: owner.id, id: company.id
      expect(assigns[:company]).to eq(Company.find(company.id))
    end

    it 'assigns @reviews' do
      session[:user_id] = owner.id
      get :show, user_id: owner.id, id: company.id
      expect(assigns[:reviews]).to eq([])
    end
  end

  describe 'GET #edit' do
    let(:owner)   { Fabricate(:user, role: 'owner') }
    let(:company) { Fabricate(:company, user_id: owner.id) }

    context 'when owner is logged in' do
      it 'assigns @company' do
        session[:user_id] = owner.id
        get :edit, user_id: owner.id, id: company.id
        expect(assigns[:company]).to be_a(Company)
      end
    end

    context 'when owner is nog togged in' do
      it 'redirects to login_path' do
        get :edit, user_id: owner.id, id: company.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:owner)   { Fabricate(:user, role: 'owner') }
    let(:company) { Fabricate(:company, user_id: owner.id) }

    context 'when owner is logged in' do
      before(:example) do
        session[:user_id] = owner.id
        patch :update,  user_id: owner.id,
                        id: company.id,
                        company: { name: 'McDonalds Slovenija' }
      end

      it 'updates companys attributes' do
        expect(company.reload.name).to eq('McDonalds Slovenija')
      end

      it 'redirects to companies index page' do
        expect(response).to redirect_to user_companies_path(owner)
      end

      it 'displays success flash message' do
        expect(flash[:success]).to eq('The Company was successfully updated!')
      end
    end

    context 'when owner is not logged in' do
      let(:owner)   { Fabricate(:user, role: 'owner') }
      let(:user)    { Fabricate(:user, role: 'user') }
      let(:company) { Fabricate(:company, user_id: owner.id) }

      it 'redirects to login page' do
        patch :update,  user_id: owner.id,
                        id: company.id,
                        company: { name: 'McDonalds Slovenija' }

        expect(response).to redirect_to(login_path)
      end

      it 'does not update company attributes' do
        session[:user_id] = user.id

        patch :update,  user_id: owner.id,
                        id: company.id,
                        company: { name: 'McDonalds Slovenija' }
        expect(company.reload.name).to eq(company.name)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:owner)       { Fabricate(:user, role: 'owner') }
    let(:other_owner) { Fabricate(:user, role: 'owner') }
    let(:user)        { Fabricate(:user, role: 'user') }
    let(:company)     { Fabricate(:company, user_id: owner.id) }

    context 'when owner is logged in' do
      before(:example) do
        session[:user_id] = owner.id
      end

      it 'redirects to companies index page' do
        delete :destroy, user_id: owner.id, id: company.id
        expect(response).to redirect_to user_companies_path(owner)
      end

      it 'deletes a company' do
        delete :destroy, user_id: owner.id, id: company.id
        expect(Company.all.count).to eq(0)
      end
    end

    context 'when owner is not logged in' do
      it 'redirects to login page' do
        delete :destroy, user_id: owner.id, id: company.id
        expect(response).to redirect_to login_path
      end

      it 'does not delete company' do
        delete :destroy, user_id: owner.id, id: company.id
        expect(Company.all.count).to eq(1)
      end
    end

    context 'other owners cannot delete other owners company' do
      it 'does not delete company' do
        session[:user_id] = other_owner.id
        delete :destroy, user_id: owner.id, id: company.id
        expect(Company.all.count).to eq(1)
      end
    end
  end

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

    it 'return empy array if no companies are found' do
      get :search, name: 'Salad & co', city: { city_id: City.first.id.to_s }, category: { category_ids: Category.first.id.to_s } 
      expect(assigns[:companies]).to eq([])
    end

    it 'returnes search result indipendent of users inputs case' do
      get :search, name: 'IdAs', city: { city_id: '' }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_2, company_3])
    end

    it 'returns all companies if user only hits search without any parameters' do
      get :search, name: '', city: { city_id: '' }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_1, company_2, company_3])
    end

    it 'searches through all companies if user only submits name' do
      get :search, name: 'ike', city: { city_id: '' }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_1])
    end

    it 'searches throught companies with same city if user fills in name and chooses city' do
      get :search, name: 'das', city: { city_id: city_1 }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_3])
    end

    it 'searches through companies with same category if user fills in name and chooses category' do
      get :search, name: 'das', city: { city_id: '' }, category: { category_ids: category_1.id } 
      expect(assigns[:companies]).to match_array([company_2])
    end

    it 'searches throught companies with same city and category if user fills in the whole form' do
      get :search, name: 'das', city: { city_id: city_2.id }, category: { category_ids: category_1.id } 
      expect(assigns[:companies]).to match_array([company_2])
    end

    it 'returns companies in the same city if user only chooses city' do
      get :search, name: '', city: { city_id: city_1.id }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_1, company_3])
    end

    it 'returns companies in the same category if user only chooses category' do
      get :search, name: '', city: { city_id: '' }, category: { category_ids: category_1 } 
      expect(assigns[:companies]).to match_array([company_1, company_2])
    end

    it 'returnes company if there is only name submited' do
      get :search, name: 'das', city: { city_id: '' }, category: { category_ids: '' } 
      expect(assigns[:companies]).to match_array([company_3, company_2])
    end
  end
end
