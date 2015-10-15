require 'rails_helper'

describe MessagesController do

  describe 'GET #new' do
    let(:user)   { Fabricate(:user) }
    let(:friend) { Fabricate(:user) }

    context 'when user is logged in' do
      it 'assigns @message' do
        session[:user_id] = user.id
        get :new, user_id: friend.id
        expect(assigns[:message]).to be_a_new(Message)
      end

      it 'assigns @friend' do
        session[:user_id] = user.id
        get :new, user_id: friend.id
        expect(assigns[:friend]).to eq(User.find(friend.id))
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        get :new, user_id: friend.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    let(:user)    { Fabricate(:user) }
    let(:friend)  { Fabricate(:user) }

    context 'when user is logged in' do
      it 'redirects to current users unread messages' do
        session[:user_id] = user.id
        post :create, user_id: friend.id, message: Fabricate.attributes_for(:message)
        expect(response).to redirect_to(user_messages_path(user))
      end

      it 'sends new message to friend' do
        session[:user_id] = user.id
        post :create, user_id: friend.id, message: Fabricate.attributes_for(:message)
        expect(Message.all.count).to eq(1)
      end

      it 'displays success flash message' do
        session[:user_id] = user.id
        post :create, user_id: friend.id, message: Fabricate.attributes_for(:message)
        expect(flash[:success]).to eq('Message was sent!')
      end

      it 'it renders new template when bad params are sent' do
        session[:user_id] = user.id
        post :create, user_id: friend.id, message: Fabricate.attributes_for(:message, content: '')
        expect(response).to render_template(:new)
      end

    end

    context 'when user is not logged in' do
      it 'redirects to login page' do
        post :create, user_id: friend.id, message: Fabricate.attributes_for(:message)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user)       { Fabricate(:user) }
    let!(:message_1) { Fabricate(:message, user_id: user.id) }

    before(:example) do
      request.env["HTTP_REFERER"] = user_messages_path(user)
    end

    it 'redirects to unread messages' do
      session[:user_id] = user.id
      delete :destroy, user_id: user.id, id: message_1.id
      expect(response).to redirect_to("/users/#{user.id}/messages")
    end

    it 'drestroys a message' do
      session[:user_id] = user.id
      delete :destroy, user_id: user.id, id: message_1.id
      expect(Message.all.count).to eq(0)
    end
  end

  describe '#important' do
    let(:user)     { Fabricate(:user) }
    let(:friend)   { Fabricate(:user) }
    let!(:message) { Fabricate(:message, user_id: user.id, friend_id: friend.id) }

    before(:example) do
      request.env["HTTP_REFERER"] = user_messages_path(user)
    end

    it 'redirects back' do
      session[:user_id] = user.id
      post :important, user_id: user.id, id: message.id
      expect(response).to redirect_to("/users/#{user.id}/messages")
    end

    it 'marks message as important' do
      session[:user_id] = user.id
      post :important, user_id: user.id, id: message.id
      expect(user.num_of_important_messages).to eq(1)
    end
  end

  describe '#unimportant' do
    let(:user)     { Fabricate(:user) }
    let(:friend)   { Fabricate(:user) }
    let(:message)  { Fabricate(:message, user_id: user.id, friend_id: friend.id, important: true) }

    before(:example) do
      request.env["HTTP_REFERER"] = user_messages_path(user, page: 'read')
    end

    it 'redirects back' do
      session[:user_id] = user.id
      post :unimportant, user_id: user.id, id: message.id
      expect(response).to redirect_to("/users/#{user.id}/messages?page=read")
    end

    it 'removes important tag' do
      session[:user_id] = user.id
      post :unimportant, user_id: user.id, id: message.id
      expect(user.num_of_important_messages).to eq(0)
      expect(user.num_of_read_messages).to eq(1)
    end
  end
end
