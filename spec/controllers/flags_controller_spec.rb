require 'rails_helper'

describe FlagsController do
  let(:admin) do
    admin = User.create(full_name: 'Admin Toni', password: 'password', role: 'user')
    admin.update(role: 'admin')
    admin
  end

  let(:user) { Fabricate(:user) }

  describe 'GET #index' do
    context 'when admin is logged in' do
      it 'assigns @flags' do
        session[:user_id] = admin.id
        get :index
        expect(assigns[:flags]).to eq(Flag.all)
      end
    end

    context 'when user or owner is logged in' do
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

  describe 'POST #create' do
    let(:flager)      { Fabricate(:user) }
    let(:flaged_user) { Fabricate(:user) }
    let(:review)      { Fabricate(:review, user: flaged_user) }

    context 'when user is logged in' do

      it 'creates flag' do
        session[:user_id] = flager.id
        xhr :post, :create, review_id: review.id, flaged_by_user_id: flager.id, flaged_user_id: review.user.id
        expect(Flag.all.count).to eq(1)
      end
    end

    context 'when user is not logged in' do
      it 'does not create a flag' do
          xhr :post, :create, review_id: review.id, flaged_by_user_id: flager.id, flaged_user_id: review.user.id
          expect(Flag.all.count).to eq(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:flag) do
      Flag.create(flaged: true)
    end

    context 'when admin is logged in' do
      it 'deletes a flag' do
        session[:user_id] = admin.id
        delete :destroy, id: flag.id
        expect(Flag.all.count).to eq(0)
      end

      it 'redirects to All flags page' do
        session[:user_id] = admin.id
        delete :destroy, id: flag.id
        expect(response).to redirect_to(flags_path)
      end
    end

    context 'when owner or user is logged in' do
      it 'redirects to login page' do
        session[:user_id] = user.id
        delete :destroy, id: flag.id
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        delete :destroy, id: flag.id
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
