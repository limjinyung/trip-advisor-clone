require 'rails_helper'

describe "signup process", type: :feature do
    User.delete_all
    it "sign up" do
        visit '/signup'
        within("form") do
            fill_in 'user[email]', with: 'test@mail.com'
            fill_in 'user[password]', with: '123'
            fill_in 'user[password_confirmation]', with: '123'
            fill_in 'user[username]', with: 'test'
        end

        click_button 'Create User'
        expect(page).to have_content 'User was successfully created.'
    end
end