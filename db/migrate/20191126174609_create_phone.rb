class CreatePhone < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
    	t.string :number
    	t.string :ddd
    	t.string :type
    	t.boolean :preferential
    	t.integer :people_id
    end
  end
end
