class AddUserIdToArmor < ActiveRecord::Migration
  def change
  	add_column :armors, :user_id, :integer 
  end
end
