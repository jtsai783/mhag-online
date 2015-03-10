class AddAliasToActiveSkill < ActiveRecord::Migration
  def change
  	add_column :active_skills, :display_alias, :integer
  end
end
