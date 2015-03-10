class CreateActiveSkillAliases < ActiveRecord::Migration
  def change
    create_table :active_skill_aliases do |t|
    	t.integer :active_skill_id
    	t.string :alias

      t.timestamps null: false
    end
  end
end
