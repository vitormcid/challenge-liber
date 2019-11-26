class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
    	t.string :name
    	t.string :last_name
    	t.string :document
    	t.string :email
    	t.date :birth_date
    	t.integer :driver_license_id
    end
  end
end
