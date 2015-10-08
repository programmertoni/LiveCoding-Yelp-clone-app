require 'rails_helper'

describe SessionsController do

  describe 'GET #new' do

    context 'when user is logged in' do
      it 'redirect user to home page' do
        session[:user_id] = Fabricate(:user).id
        get :new
        expect(response).to redirect_to(recent_reviews_path)
      end
    end

    context 'when user is not logged in' do
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

  end

  describe 'POST #create' do

    let(:user) { Fabricate(:user) }

    context 'with valid params' do
      before(:example) do
        post :create, full_name: user.full_name, password: user.password
      end

      it 'creates new session' do
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to recent reviews page' do
        expect(response).to redirect_to(root_path)
      end

      it 'displays succes flash message' do
        expect(flash[:success]).to eq("Hello #{user.full_name.titleize}! You are logged in.")
      end
    end

    context 'with invalid params' do
      it 'does not create new session' do
        post :create, full_name: user.full_name, password: ''
        expect(session[:user_id]).to be nil
      end

      it 'redirect to login_path' do
        post :create, full_name: 'wrong name', password: user.password
        expect(response).to redirect_to login_path
      end

      it 'displays danger flash message' do
        post :create, full_name: "#{user.full_name}1", password: user.password
        expect(flash[:danger]).to eq('There was something wrong with your Full Name or Password!')
      end
    end

  end

  describe 'GET #destroy' do

    let(:user) { Fabricate(:user) }

    before(:example) do
      post :create, full_name: user.full_name, password: user.password
    end

    it 'deletes users session' do
      get :destroy
      expect(session[:user_id]).to be nil
    end

    it 'redirects to recent_reviews_path' do
      get :destroy
      expect(response).to redirect_to(root_path)
    end

    it 'display success flash message' do
      get :destroy
      expect(flash[:success]).to eq("You are logged out. We hope to see you soon!")
    end

  end

end
