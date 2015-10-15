require 'rails_helper'

describe UsersController do
  describe 'GET #index' do
    let(:user) { Fabricate(:user) }

    let(:admin) do
      admin = User.create(full_name: 'Admin Toni', password: 'password', role: 'user')
      admin.update(role: 'admin')
      admin
    end

    context 'when admin is logged in' do
      it 'assigns @users to all users' do
        admin #creates admin
        session[:user_id] = admin.id
        get :index
        expect(assigns[:users]).to eq(User.all)
      end
    end

    context 'when user or owner are logged in' do
      it 'redirects to login page' do
        session[:user_id] = user.id
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { Fabricate(:user) }

    let(:admin) do
      admin = User.create(full_name: 'Admin Toni', password: 'password', role: 'user')
      admin.update(role: 'admin')
      admin
    end

    context 'when admin is logged in' do
      it 'deletes a user' do
        admin #creates admin
        session[:user_id] = admin.id
        delete :destroy, id: user.id
        expect(User.all.count).to eq(1)
      end

      it 'redirects to all users page' do
        admin #creates admin
        session[:user_id] = admin.id
        delete :destroy, id: user.id
        expect(response).to redirect_to(users_path)
      end
    end

    context 'when user or owner is logged in' do
      it 'redirects to login page' do
        session[:user_id] = user.id
        delete :destroy, id: 69
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when user is not logged in'
      it 'redirects to login page' do
        delete :destroy, id: 69
        expect(response).to redirect_to(login_path)
      end
    end

  describe 'GET #new' do
    it 'assigns a @user variable' do
      get :new
      expect(assigns[:user]).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before(:example) do
        post :create, user: { full_name: 'Toni Cesarek', password: 'password', role: 'user' }
      end

      it 'redirects_to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'creates new user' do
        expect(User.all.count).to eq(1)
      end

      it 'displays success flash message' do
        expect(flash[:success]).to eq("Welcome Toni Cesarek! You are now logged in!")
      end

      it 'logs in the new user' do
        expect(session[:user_id]).not_to be nil
      end
    end

    context 'with invalid params' do
      it 'renders new template' do
        post :create, user: { full_name: '', password: 'password', role: 'owner' }
        expect(response).to render_template(:new)
      end

      it 'does not create new user' do
        post :create, user: { full_name: 'Balonko Slav', password: '', role: 'user' }
        expect(User.all.count).to eq(0)
      end

      it 'assigns new user' do
        post :create, user: { full_name: 'Balonko Slav', password: '', role: 'user' }
        expect(assigns[:user]).to be_a_new(User)
      end

      it 'user cannont be created with a role of admin' do
        post :create, user: { full_name: 'Hacker Hackingtosh', password: 'password', role: 'admin' }
        expect(User.all.count).to eq(0)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is logged in' do
      let(:user) { Fabricate(:user) }

      it 'assigns @user' do
        session[:user_id] = user.id 
        get :edit, id: user.id
        expect(assigns[:user]).to eq(User.first)
      end
    end

    context 'when user is not logged in' do
      let(:user) { Fabricate(:user) }

      it 'redirects to login_path' do
        get :edit, id: user.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is logged in' do
      let(:user) { Fabricate(:user, role: 'user') }
      before(:example) { session[:user_id] = user.id }

      it 'redirects to edit_path' do
        patch :update, id: user.id, user: { full_name: user.full_name, password: '', role: user.role }
        expect(response).to redirect_to(edit_user_path(user))
      end

      it 'displays success flash message' do
        patch :update, id: user.id, user: { full_name: user.full_name, password: '', role: user.role }
        expect(flash[:success]).to eq("You've successfuly updated you're account settings.")
      end

      it 'assigns @user' do
        patch :update, id: user.id, user: { full_name: user.full_name, password: '', role: user.role }
        expect(assigns[:user]).to eq(User.first)
      end

      it 'updates only full_name' do
        patch :update, id: user.id, user: { full_name: 'Tonko Balkonko', password: '', role: user.role }
        expect(User.first.full_name).to eq('Tonko Balkonko')
      end

      it 'updates full_name, password' do
        patch :update, id: user.id, user: { full_name: 'Tonko Balonko', password: 'NewPassword' }
        expect(User.first.full_name).to eq('Tonko Balonko')
      end

      it 'cannot update role to admin' do
        patch :update, id: user.id, user: { full_name: user.full_name, password: '', role: 'admin' }
        expect(User.first.role).to eq('user')
      end

      it 'cannot update diffrent users credentials' do
        diffrent_user = Fabricate(:user)
        patch :update, id: diffrent_user.id, user: { full_name: 'Tonko Balonko', password: '', role: 'owner' }
        expect(User.last.full_name).to eq(diffrent_user.full_name)
        expect(User.last.role).to eq(diffrent_user.role)
      end
    end

    context 'when user is not logged in' do
      let(:user) { Fabricate(:user) }

      it 'is redirected to login_path' do
        patch :update, id: user.id, user: { full_name: user.full_name, password: '', role: user.role }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #reviews' do
    let!(:user)      { Fabricate(:user) }
    let!(:company_1) { Fabricate(:company) }
    let!(:company_2) { Fabricate(:company) }

    before(:example) do
      @review_1 = Review.create(stars: 1, content: 'some text', user_id: user.id, company_id: company_1.id)
      @review_2 = Review.create(stars: 1, content: 'some text', user_id: user.id, company_id: company_2.id, created_at: 1.minute.ago, updated_at: 1.minute.ago)
    end

    context 'when user is logged in' do
      it 'displays all the users reviews ordered newest first' do
        session[:user_id] = user.id
        get :reviews, id: user.id
        expect(assigns[:reviews]).to match_array([@review_2, @review_1])
      end
      it 'orders review by newest first' do
        session[:user_id] = user.id
        get :reviews, id: user.id
        expect(assigns[:reviews]).to eq([@review_1, @review_2])
      end
    end
  end

  describe 'GET #public_reviews' do
    let!(:user)   { Fabricate(:user) }
    let!(:review) { Fabricate(:review, user: user) }

    context 'when user is logged in' do
      it 'assigns @reviews' do
        session[:user_id] = user.id
        get :public_reviews, id: user.id
        expect(assigns[:reviews]).to eq(user.reviews)
      end

      it 'assigns @user' do
        session[:user_id] = user.id
        get :public_reviews, id: user.id
        expect(assigns[:user]).to eq(user)
      end
    end
  end
end
