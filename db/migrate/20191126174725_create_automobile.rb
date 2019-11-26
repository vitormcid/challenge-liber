class CreateAutomobile < ActiveRecord::Migration[6.0]
  def change
    create_table :automobiles do |t|
    	t.string :model
    	t.string :color
    	t.string :year
    	t.string :license_plate
    	t.string :type
    	t.float  :daily_cost
    end
  end
end
