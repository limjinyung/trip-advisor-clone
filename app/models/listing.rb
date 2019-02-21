class Listing < ApplicationRecord
    belongs_to :user

    def self.search_location_name(query)
		where("location_name ILIKE :location_name", location_name: "%#{query}%").map do |record|
      		record.location_name 
  		end
	end
end
