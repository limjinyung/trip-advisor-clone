require 'rails_helper'

RSpec.describe User, type: :model do
    before :each do
        User.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!(:users);
        User.create(email: 'user@mail.com', password_digest: '123456', username: 'user')
    end

    #check all email possible errors
    context 'Sign up check - email presence' do
        it 'error: cannot sign up without email' do
            user = User.create(password: '123', username: 'user1')
            expect(user).not_to be_valid
        end
    end

    context 'Sign up check - email format' do
        it 'error: email format incorrect - absent @' do
            user = User.create(email: 'user1mail.com', password: '123', username: 'user1')
            expect(user).not_to be_valid
        end
    end

    context 'Sign up check - email uniqueness' do
        it 'error: email cannot be the same' do
            user = User.create(email: 'user1mail.com', password: '123', username: 'user1')
            user1 = User.create(email: 'user1mail.com', password: '345', username: 'user2')
            expect(user).not_to be_valid
        end
    end

    #test email
    context 'Sign up test - email' do
        it 'success: user created' do
            user = User.create(email: 'user2@mail.com', password: '123', username: 'user1')
            expect(user).to be_valid
        end
    end

    #check username presence
    context 'Sign up check - username presence' do
        it 'error: username must not be empty' do
            user = User.create(email: 'user3@mail.com', password: '123')
            expect(user).not_to be_valid
        end
    end

    #test username
    context 'Sign up test - username' do
        it 'success: user created' do
            user = User.create(email: 'user4@mail.com', password: '123', username: 'user1')
            expect(user).to be_valid
        end
    end

    #user check associations 
    context 'User association check' do
        it 'error: belongs_to listing' do
            expect(User.reflect_on_association(:listings).macro).not_to eq(:belongs_to)
        end

        it 'success: has many listings' do
            expect(User.reflect_on_association(:listings).macro).to eq(:has_many)
        end
    end

    #check custom model
    context 'Destroy_user check' do
        it 'success: user deleted successfully' do
            expect(User.destroy(1)).to eq(true)
        end

        it 'error: user does not exist' do
            expect(User.destroy(2)).to eq(false)
        end
    end
end