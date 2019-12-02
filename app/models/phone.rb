class Phone < ApplicationRecord
	belongs_to :person, foreign_key:"people_id", required: false
	validate :validate_uniqueness_preferential

	def validate_uniqueness_preferential
		return unless preferential == true
		preferential_phones = Phone.where(people_id: people_id, preferential: true)
		if preferential_phones.present?
		   self.errors[:base] << "Já existe um telefone preferencial para essa pessoa"
		end	
	end

end
