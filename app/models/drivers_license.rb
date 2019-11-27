class DriversLicense < ApplicationRecord
	has_one :person, required: false, foreign_key: "driver_license_id"
end
