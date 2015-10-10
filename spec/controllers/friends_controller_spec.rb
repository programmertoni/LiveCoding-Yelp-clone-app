require 'rails_helper'

describe FriendsController do

  describe 'GET #index' do
    let!(:user)     { Fabricate(:user) }
    let!(:user_2)   { Fabricate(:user) }
    let!(:user_3)   { Fabricate(:user) }
    let!(:user_4)   { Fabricate(:user) }
    let!(:friend_1) { Friend.create(pending: false,
                      user_blocked: false,
                      user: user,
                      id_of_friend: user_2.id) }


    context 'when user is logged in' do
      it 'assigns @users not listing the same user' do
        session[:user_id] = user.id
        get :index
        expect(assigns[:not_friends]).to match_array([user_3, user_4])
      end

      it 'lists all users that are not users friend' do
        session[:user_id] = user.id
        get :index
        expect(assigns[:not_friends]).to match_array([user_3, user_4])
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #search-friend' do
    let!(:user)   { Fabricate(:user, full_name: 'Toni Cesarek') }
    let!(:dadi)   { Fabricate(:user, full_name: 'Dadi Nabaladi') }
    let!(:marjan) { Fabricate(:user, full_name: 'Marjan Dzmancek') }
    let!(:alenka) { Fabricate(:user, full_name: 'Alenka Dzmancek') }

    context 'when user is logged in' do
      it 'returnes empty array if no search term is found' do
        session[:user_id] = user.id
        get :search, name: 'joze'
        expect(assigns[:search_result]).to eq([])
      end

      it 'returnes user with same name of search term' do
        session[:user_id] = user.id
        get :search, name: 'Alenka'
        expect(assigns[:search_result]).to eq([alenka])
      end

      it 'does not mater if search name is upcase or downcase or starts or ends with full_name of the user' do
        session[:user_id] = user.id
        get :search, name: 'ZmA'
        expect(assigns[:search_result]).to match_array([marjan, alenka])
      end
    end

    context 'when user is not logged in' do
      it 'redirects to loggin page' do
        get :search, name: 'tonko'
        expect(response).to redirect_to(login_path)
      end
    end

  end

end
