class CreateDecorations < ActiveRecord::Migration
  def change
    create_table :decorations do |t|
    	t.string :name
    	t.integer :rarity
    	t.integer :slots
    	t.integer :avail_online
    	t.integer :avail_offline

      t.timestamps null: false
    end
  end
end
