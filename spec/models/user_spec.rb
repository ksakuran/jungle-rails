require 'rails_helper'

# validates :first_name, presence: true
# validates :last_name, presence: true
# validates :email, presence: true, uniqueness: { case_senstive: false }
# validates :password, presence: true, length: { minimum: 8 }, confirmation: true
# validates :password_confirmation, presence: true

RSpec.describe User, type: :model do
  describe 'Validations' do
  
    it "passes validation for valid input" do
      user = User.new(first_name: "first", last_name: "last", password: "1234abcd", password_confirmation: "1234abcd", email: "test@test.com")
        expect(user).to be_valid       
    end

    it "requires a password" do
      user = User.new(first_name: "first", last_name: "last", password: nil, password_confirmation: nil, email: "test@test.com")
      expect(user).not_to be_valid
      expect(user.errors.full_messages_for(:password)).to include("Password can't be blank")
    end

    it "requires password to match the password confirmation" do
      user = User.new(first_name: "first", last_name: "last", password: "1234abcdefg", password_confirmation: "1234abcd", email: "test@test.com")
      expect(user).not_to be_valid
      expect(user.errors.full_messages_for(:password_confirmation)).to include("Password confirmation doesn't match Password")
    end

    it "requires the password to be 8 characters minimum" do
      user = User.new(first_name: "first", last_name: "last", password: "1234abc", password_confirmation: "1234abc", email: "test@test.com")
      expect(user).not_to be_valid
      expect(user.errors.full_messages_for(:password)).to include("Password is too short (minimum is 8 characters)")
    end

    it "requires a first name" do
      user = User.new(first_name: nil, last_name: "last", password: "1234abcd", password_confirmation: "1234abcd", email: "test@test.com")
      expect(user).not_to be_valid
      expect(user.errors.full_messages_for(:first_name)).to include("First name can't be blank")
    end

    it "requires a last name" do
      user = User.new(first_name: "first", last_name: nil, password: "1234abcd", password_confirmation: "1234abcd", email: "test@test.com")
      expect(user).not_to be_valid
      expect(user.errors.full_messages_for(:last_name)).to include("Last name can't be blank")
    end


    it "requires a unique email address, regardless of letter case" do
      user1 = User.new(first_name: "first", last_name: "last", password: "1234abcd", password_confirmation: "1234abcd", email: "test@test.COM")
      user1.save
      user2 = User.new(first_name: "first", last_name: "last", password: "1234abcd", password_confirmation: "1234abcd", email: "test@TEST.com")
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages_for(:email)).to include("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do
   
    before do
      @user = User.create(first_name: 'Jane', last_name: 'Doe', email: 'janedoe@test.com', password: 'abcd1234', password_confirmation: 'abcd1234')
    end

    it "should authenticate a user with valid credentials" do
      authenticated_user = User.authenticate_with_credentials('janedoe@test.com', 'abcd1234')
      expect(authenticated_user).to eq(@user)
    end

    it "should not authenticate a user when given an incorrect password" do
      authenticated_user = User.authenticate_with_credentials('janedoe@test.com', 'blah1234')
      expect(authenticated_user).to be_nil
    end


    it "should not authenticate a user when given an incorrect email" do
      authenticated_user = User.authenticate_with_credentials('jane@test.com', 'abcd1234')
      expect(authenticated_user).to be_nil
    end

    it "should authenticate a user when the email has whitespace on either end" do
      authenticated_user = User.authenticate_with_credentials('  janedoe@test.com  ', 'abcd1234')
      expect(authenticated_user).to eq(@user)
    end

    it "should authenticate a user regardless of letter case for the email" do
      authenticated_user = User.authenticate_with_credentials('janedoe@TEST.com', 'abcd1234')
      expect(authenticated_user).to eq(@user)
    end

  end
end
