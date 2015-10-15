require 'rails_helper'

describe Message do
  it { is_expected.to belong_to(:user) }

  # validations
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }

  let!(:user)          { Fabricate(:user) }
  let!(:unread_msg)    { Fabricate(:message, user_id: user.id, message_read: false ) }
  let!(:unread_msg_2)    { Fabricate(:message, user_id: user.id, message_read: false ) }
  let!(:read_msg)      { Fabricate(:message, user_id: user.id, message_read: true ) }
  let!(:important_msg) { Fabricate(:message, user_id: user.id, message_read: true, important: true ) }

  describe '#unread_messages' do
    it 'returnes only unread messages' do
      expect(user.unread_messages).to match_array([unread_msg, unread_msg_2])
    end
  end

  describe '#num_of_unread_messages' do
    it 'returnes only number unread messages' do
      expect(user.num_of_unread_messages).to eq(2)
    end
  end

  describe '#read_messages' do
    it 'returnes only read messages' do
      expect(user.read_messages).to match_array([read_msg])
    end
  end

  describe '#num_of_read_messages' do
    it 'returnes only number read messages' do
      expect(user.num_of_read_messages).to eq(1)
    end
  end

  describe '#important_messages' do
    it 'returnes only important messages' do
      expect(user.important_messages).to eq([important_msg])
    end
  end

  describe '#num_of_important_messages' do
    it 'returnes only number important messages' do
      expect(user.num_of_important_messages).to eq(1)
    end
  end
end
