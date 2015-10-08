require 'rails_helper'

describe UsersController do

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

end
