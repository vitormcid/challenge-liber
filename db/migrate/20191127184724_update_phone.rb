class UpdatePhone < ActiveRecord::Migration[6.0]
  def change
  	rename_column :phones, :type, :kind
  end
end
