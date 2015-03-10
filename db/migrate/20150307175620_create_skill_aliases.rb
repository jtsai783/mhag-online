class CreateSkillAliases < ActiveRecord::Migration
  def change
    create_table :skill_aliases do |t|
    	t.integer :skill_id
    	t.string :alias

      t.timestamps null: false
    end
  end
end
