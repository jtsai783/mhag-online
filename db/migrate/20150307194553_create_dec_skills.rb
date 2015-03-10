class CreateDecSkills < ActiveRecord::Migration
  def change
    create_table :dec_skills do |t|
    	t.integer :skill_id
    	t.integer :decocation_id

      t.timestamps null: false
    end
  end
end
