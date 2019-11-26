class CreateDriversLicense < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers_licenses do |t|
    	t.string :number
    	t.string :modalities
    	t.date 	 :validiy
    end
  end
end
