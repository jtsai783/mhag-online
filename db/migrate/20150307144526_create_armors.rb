class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
    	t.string :name
    	t.integer :sex
    	t.integer :klass
    	t.integer :rarity
    	t.integer :slots, null: false, default: 0
    	t.integer :avail_online
    	t.integer :avail_offline
    	t.integer :initial_def
    	t.integer :final_def
    	t.integer :fire_resist
    	t.integer :water_resist
    	t.integer :thunder_resist
    	t.integer :ice_resist
    	t.integer :dragon_resist

      t.timestamps null: false
    end
  end
end
