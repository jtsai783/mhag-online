class AddAliasIdToSkills < ActiveRecord::Migration
  def change
  	add_column :skills, :alias_id, :integer
  end
end
