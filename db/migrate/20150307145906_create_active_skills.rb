class CreateActiveSkills < ActiveRecord::Migration
  def change
    create_table :active_skills do |t|
    	t.string :name
    	t.integer :skill_id
    	t.integer :points

      t.timestamps null: false
    end
  end
end
