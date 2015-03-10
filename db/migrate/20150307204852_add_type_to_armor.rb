class AddTypeToArmor < ActiveRecord::Migration
  def change
  	add_column :armors, :armor_type, :string
  end
end
