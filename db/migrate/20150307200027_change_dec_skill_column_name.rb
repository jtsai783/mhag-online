class ChangeDecSkillColumnName < ActiveRecord::Migration
  def change
  	rename_column :dec_skills, :decocation_id, :decoration_id
  end
end
