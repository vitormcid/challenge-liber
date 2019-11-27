class DriversLicense < ApplicationRecord
	belongs_to :person, required: false
end
