class Location < ApplicationRecord
	belongs_to :person, foreign_key: "people_id"
	belongs_to :automobile, foreign_key: "automobile_id"
end
