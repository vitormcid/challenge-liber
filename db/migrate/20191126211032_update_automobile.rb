class UpdateAutomobile < ActiveRecord::Migration[6.0]
  def change
  	rename_column :automobiles, :type, :kind
  end
end
