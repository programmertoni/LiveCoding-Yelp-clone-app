require 'rails_helper'

describe User do

  context 'with valid data' do

    it 'saves user' do
      Fabricate(:user)
      expect(User.all.count).to eq(1)
    end

  end

  context 'with invalid data' do

    it 'does not save user without password' do
      user = Fabricate.build(:user, password: '')
      user.valid?
      expect(user.errors.full_messages).to eq(["Password can't be blank"])
    end

    it 'does not save user without role' do
      user = Fabricate.build(:user, role: '')
      user.valid?
      expect(user.errors.full_messages).to eq(["Role can't be blank"])
    end

    it 'does not save user without full_name' do
      user = Fabricate.build(:user, full_name: '')
      user.valid?
      expect(user.errors.full_messages).to eq(["Full name can't be blank"])
    end

    it 'does not save user if same full_name exists in database' do
      Fabricate(:user, full_name: 'Toni Cesarek')
      user = Fabricate.build(:user, full_name: 'Toni Cesarek')
      user.valid?
      expect(user.errors.full_messages).to eq(['Full name has already been taken'])
    end

  end

end
