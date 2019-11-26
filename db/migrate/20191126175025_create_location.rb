class CreateLocation < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
    	t.integer :people_id
    	t.integer :automobile_id
    	t.float   :value
    	t.date    :start_date
    	t.date    :end_date
    	t.date    :withdrawal_date
    	t.date    :return_date
    end
  end
end
