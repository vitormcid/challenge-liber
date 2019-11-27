class Location < ApplicationRecord
	belongs_to :person, foreign_key: "people_id"
	belongs_to :automobile, foreign_key: "automobile_id"

	scope :active, -> { where("withdrawal_date is not ? and return_date is ?", nil,nil) }
	scope :without_delay, -> { where("return_date <= end_date") }
	
	validates :person, :automobile, presence: true
	validate :validate_location_uniqueness
	validate :validate_person_age
	validate :validate_bus_location
	validate :validate_truck_location
	validate :validate_large_locations
	validate :validate_wednesday_location
	validate :validate_license_expiration


	def validate_location_uniqueness
		if (person.present? and person.locations.where(people_id: people_id).active.present? &&
			withdrawal_date.present? && !return_date.present?)
			self.errors[:base] << "Ja existe uma alocacao ativa para essa pessoa"
		end		
	end	

	def validate_person_age
		if !validate_compatible_age(21)
			self.errors[:base] << "A pessoa nao pode realizar a locacao"
		end	
	end

	def validate_bus_location
		return unless automobile.kind == "bus"
		if !(validate_compatible_age(40) && validate_compatible_license("C"))
			self.errors[:base] << "A pessoa nao pode realizar a alocacao de um onibus"
		end	
	end

	def validate_truck_location
		return unless automobile.kind == "truck"
		if !(validate_compatible_age(60) && validate_compatible_license("E"))
			self.errors[:base] << "A pessoa nao pode realizar a alocacao de um caminhao"
		end	
	end

	def validate_large_locations
		if location_duration > 4 and !person.reliable_customer
			self.errors[:base] << "A pessoa nao pode realizar uma alocacao maior que 4 dias"
		end	
	end	

	def validate_wednesday_location
		if Date.current.strftime('%A') == "Wednesday" &&
		   automobile.license_plate_termination == "4"
		   	self.errors[:base] << "Esse Carro nao pode ser alugado nas quartas feiras"
		end	
	end

	def validate_license_expiration
		if person&.drivers_license&.validiy < Date.current
			self.errors[:base] << "A pessoa esta com a licensa vencida e por isso nao pode alugar carros"
		end	
	end		

	def location_duration		
		return unless start_date.present? and end_date.present?
		(end_date - start_date).to_i/86400
	end	

	def validate_compatible_age(age)
		!person.birth_date.blank? && !(person.birth_date + age.years > Date.current)
	end	

	def validate_compatible_license(kind)
		return false unless person.drivers_license.present?
		person&.drivers_license&.modalities&.include?(kind)		
	end

end
