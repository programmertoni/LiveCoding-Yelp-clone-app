require 'rails_helper'

describe ReviewsController do

  describe 'GET #home' do

    context 'when user is logged in' do

      it 'renders the home page' do
        session[:user_id] = Fabricate(:user).id
        get :recent
        expect(response).to render_template(:recent)
      end

    end

    context 'when user is not logged in' do

    end

  end

end
