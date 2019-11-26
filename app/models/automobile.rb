class Automobile < ApplicationRecord
	extend Enumerize
  	enumerize :kind, in: [:car, :motorcycle, :vuc, :bus, :truck]

  	def license_plate_termination
  		license_plate.slice(license_plate.length - 1)
  	end	
end
