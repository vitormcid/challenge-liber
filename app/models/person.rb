class Person < ApplicationRecord
	has_many :phones, foreign_key: "people_id"
	has_many :locations, foreign_key: "people_id"
	belongs_to :drivers_license, foreign_key: "driver_license_id", required: false

	def reliable_customer
		return unless locations.present?
		locations.without_delay.count >= 2
	end	
end
