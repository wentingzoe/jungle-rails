require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 

    it 'is valid with matching password and password_confirmation fields' do
      @user = User.new(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
      expect(@user).to be_valid
    end

    it 'is invalid with non-matching password and password_confirmation fields' do
      @user = User.new(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalals")
      expect(@user).to_not be_valid
    end

    it 'is valid with unique emails' do 
       @user1 = User.new(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
      expect(@user1).to be_valid
       @user2 = User.new(name: "Yeah", email: "happy@456.com", password:"lalala", password_confirmation:"lalala")
      expect(@user2).to be_valid
    end

    it 'is invalid with repeated emails' do 
      @user1 = User.new(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
      expect(@user1).to be_valid
      @user1.save!
      @user2 = User.new(name: "Yeahh", email: "happy@123.com", password:"yoyoyo", password_confirmation:"yoyoyo")
      expect(@user2).to_not be_valid
    end

    it 'must have a minimum password length when a user account is being created' do
      @user = User.new(name: "Yeah", email: "happy@123.com", password:"yoyo", password_confirmation:"lalala")
      expect(@user).to_not be_valid
    end

    it 'requires emails and name' do
      @user = User.new(name:nil, email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
      expect(@user).to_not be_valid
    end
  end

   describe '.authenticate_with_credentials' do
      it 'must login when a registered user provides the correct email and password' do
          @user = User.create(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
        expect(User.authenticate_with_credentials("happy@123.com", "lalala")).to eql(@user)
      end

      it 'must login and be case insensitive for e-mails' do
        @user = User.create(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
        expect(User.authenticate_with_credentials("HAPPY@123.com", "lalala")).to eq(@user)
      end

      it 'must login and ignore leading and trailing spaces for e-mails' do
          @user = User.create(name: "Yeah", email: "happy@123.com", password:"lalala", password_confirmation:"lalala")
        expect(User.authenticate_with_credentials("     happy@123.com", "lalala")).to eq(@user)
      end
   end

 
end