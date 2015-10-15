require 'rails_helper'

describe Review do
  it { is_expected.to have_many(:flags).dependent(true) }
  it { is_expected.to have_many(:votes).dependent(true) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:user) }

  # validations
  it { is_expected.to validate_presence_of(:stars) }
  it { is_expected.to validate_presence_of(:content) }

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

  describe '#voted_on_useful_vote_by?(current_user)' do
    let(:user)   { Fabricate(:user) }
    let(:review) { Fabricate(:review) }

    it 'returns true if user has already voted on useful vote' do
      Vote.create(vote_type: 'useful', review_id: review.id, user_id: user.id)
      expect(review.voted_on_useful_vote_by?(user)).to be true
    end

    it 'returns false if user has not jet voted on useful vote' do
      expect(review.voted_on_useful_vote_by?(user)).to be false
    end
  end

  describe '#voted_on_funny_vote_by?(current_user)' do
    let(:user)   { Fabricate(:user) }
    let(:review) { Fabricate(:review) }

    it 'returns true if user has already voted on funny vote' do
      Vote.create(vote_type: 'funny', review_id: review.id, user_id: user.id)
      expect(review.voted_on_funny_vote_by?(user)).to be true
    end

    it 'returns false if user has not jet voted on funny vote' do
      expect(review.voted_on_funny_vote_by?(user)).to be false
    end
  end

  describe '#voted_on_cool_vote_by?(current_user)' do
    let(:user)   { Fabricate(:user) }
    let(:review) { Fabricate(:review) }

    it 'returns true if user has already voted on cool vote' do
      Vote.create(vote_type: 'cool', review_id: review.id, user_id: user.id)
      expect(review.voted_on_cool_vote_by?(user)).to be true
    end

    it 'returns false if user has not jet voted on cool vote' do
      expect(review.voted_on_cool_vote_by?(user)).to be false
    end
  end
end
