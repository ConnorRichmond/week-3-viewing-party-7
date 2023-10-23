require 'rails_helper'

RSpec.describe "Log in page" do 

  before do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password", password_confirmation: "password")

    visit login_path
  end
  it "can log in a user if valid password is input" do
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_button "Log In"

    expect(current_path).to eq(user_path(@user1.id))
  end 

  it "doesn't log you in if the user doesn't exist" do
    fill_in :email, with: "User Three"
    fill_in :password, with: "password"

    click_button "Log In"

    expect(current_path).to eq(login_path)
  end

  it "doesn't log you in if the password is incorrect" do
    fill_in :email, with: @user1.email
    fill_in :password, with: "not_password"

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Credentials are incorrect")

  end
end