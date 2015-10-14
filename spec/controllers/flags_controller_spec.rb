require 'rails_helper'

describe FlagsController do

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

end
