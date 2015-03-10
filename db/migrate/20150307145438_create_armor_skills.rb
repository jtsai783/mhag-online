class CreateArmorSkills < ActiveRecord::Migration
  def change
    create_table :armor_skills do |t|
    	t.integer :armor_id
    	t.integer :skill_id
    	t.integer :points

      t.timestamps null: false
    end
  end
end
