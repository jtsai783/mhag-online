class AddPointsToDecSkill < ActiveRecord::Migration
  def change
  	add_column :dec_skills, :points, :integer
  end
end
