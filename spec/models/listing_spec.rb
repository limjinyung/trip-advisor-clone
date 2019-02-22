require 'rails_helper'

RSpec.describe Listing, type: :model do
    before :each do
        User.delete_all
        Listing.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!(:listings);
        ActiveRecord::Base.connection.reset_pk_sequence!(:users);
        User.create(email: 'user@mail.com', password_digest: '123456', username: 'user')
        Listing.create(location_name: 'Next Academy', email: "user@mail.com", address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', phone_number: '0123358596', ratings: '2', user_id: 1)
    end

    #check all email possible errors
    context 'Create Listing check - email presence' do
        it 'error: cannot sign up without email' do
            listing = Listing.create(location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', phone_number: '0123358596')
            expect(listing).not_to be_valid
        end
    end

    context 'Create Listing check - email format' do
        it 'error: email format incorrect - absent @' do
            listing = Listing.create(email: 'user1mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596')
            expect(listing).not_to be_valid
        end
    end

    context 'Create Listing check - email uniqueness' do
        it 'error: email cannot be the same' do
            listing = Listing.create(email: 'user2mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596')
            listing1 = Listing.create(email: 'user2mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596')
            expect(listing).not_to be_valid
        end
    end

    #test email
    context 'Create Listing test - email' do
        it 'success: listing created' do
            listing = Listing.create(email: 'user4@mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596', user_id: 1)
            expect(listing).to be_valid
        end
    end

    #user must be presence
    context 'Create Listing check - user_id absent' do
        it 'error: user must be presence' do
            listing = Listing.create(email: 'user5@mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596')
            expect(listing).not_to be_valid
        end
    end

    #test presence of user_id
    context 'Create Listing test - user_id' do
        it 'success: listing created' do
            listing = Listing.create(email: 'user6@mail.com', location_name: 'Next Academy', address: 'AG-7, Glomac Damansara, Jalan Damansara, Tmn Tun Dr Ismail, 60000', email: 'user1@mail.com', phone_number: '0123358596', user_id: 1)
            expect(listing).to be_valid
        end
    end

    #check listing associations
    context 'Listing association check' do
        it 'error: belongs_to user' do
            expect(Listing.reflect_on_association(:user).macro).not_to eq(:has_many)
        end

        it 'success: has many user' do
            expect(Listing.reflect_on_association(:user).macro).to eq(:belongs_to)
        end
    end

    #check custom model
    context 'Destroy listing check' do
        it 'success: listing deleted successfully' do
            expect(Listing.destroy_listing(1)).to eq(true)
        end

        it 'error: listing does not exist' do
            expect(Listing.destroy_listing(2)).to eq(false)
        end
    end
end
