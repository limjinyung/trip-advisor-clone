class Listing < ApplicationRecord
		belongs_to :user
		
		validates :location_name, presence: true
		validates :address, presence: true
		validates :email, presence: true, uniqueness: true
		validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
		validates :phone_number, numericality: { only_integer: true }

    def self.search_location_name(query)
		where("location_name ILIKE :location_name", location_name: "%#{query}%").map do |record|
      		record.location_name 
  		end
	end

	def self.destroy_listing(id)
    return false if Listing.where(id: id) == []
    return true if Listing.find(id).destroy
  end
end
