require 'rails_helper'

describe Review do

  it { is_expected.to have_many(:flags).dependent(true) }
  it { is_expected.to have_many(:votes).dependent(true) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:stars) }
  it { is_expected.to validate_presence_of(:content) }
  # it { is_expected.to validate_uniqueness_of(:user_id).scoped_to([:user_id, :company_id]) }

  describe '#flaged_by?(user)' do
    let(:user)   { Fabricate(:user) }
    let(:review) { Fabricate(:review) }

    it 'returnes false if user has not flaged this review' do
      expect(review.flaged_by?(user)).to be false
    end

    it 'returnes true if user has flaged this review' do
      Flag.create(flaged: true, review_id: review.id, flaged_by_user_id: user.id)
      expect(review.flaged_by?(user)).to be true
    end
  end
end
