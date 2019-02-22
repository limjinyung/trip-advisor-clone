require 'faker'

User.delete_all
Listing.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(:users);
ActiveRecord::Base.connection.reset_pk_sequence!(:listings);

User.create(
    email: "admin@mail.com",
    first_name: "Jin Yung",
    last_name: "Lim",
    password: "990114",
    password_confirmation: "990114",
    username: "limjy",
    about_me: "First admin",
    role: 1,
)


# Seed Users
user = {}
user['password'] = 'asdf1234'
user['password_confirmation'] = 'asdf1234'

ActiveRecord::Base.transaction do
  40.times do 

    user['email'] = Faker::Internet.email
    user['role'] = 0
    user['username'] = Faker::App.name
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name 
    user['about_me'] = Faker::TvShows::GameOfThrones.quote

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
ph = [012335623, 0122551132, 0123777634, 0160352670, 0132345734, 0126463754]
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  80.times do 
    listing['user_id'] = uids.sample
    listing['location_name'] = Faker::Address.street_address
    listing['address'] = Faker::Address.full_address
    listing['email'] = Faker::Internet.email
    listing['phone_number'] = ph.sample
    listing['ratings'] = rand(1..5)

    Listing.create(listing)
  end
end