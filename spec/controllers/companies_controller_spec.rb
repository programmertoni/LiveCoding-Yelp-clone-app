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
                user_id: owner.id, company: Fabricate.attributes_for(:company)
          expect(Company.all.count).to eq(1)
          expect(flash[:success]).to eq("You've just created new company!")
        end
      end

      context 'with invalid params' do
        it 'renders new template to display errors' do
          skip
          post :create,
                user_id: owner.id, company: Fabricate.attributes_for(:company, name: '', price_range: nil)
          expect(response).to render_template(:new)
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
              user_id: user.id, company: Fabricate.attributes_for(:company)
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
      get :show, user_id: owner.id, id: company.id
      expect(assigns[:company]).to eq(Company.find(company.id))
    end

    it 'assigns @reviews' do
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

end
