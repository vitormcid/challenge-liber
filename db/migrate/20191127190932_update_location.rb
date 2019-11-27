class UpdateLocation < ActiveRecord::Migration[6.0]
  def change
  	change_column :locations, :start_date, :datetime
  	change_column :locations, :end_date, :datetime
  	change_column :locations, :withdrawal_date, :datetime
  	change_column :locations, :return_date, :datetime
  end
end
