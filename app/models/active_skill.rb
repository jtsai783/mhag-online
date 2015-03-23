# == Schema Information
#
# Table name: active_skills
#
#  id            :integer          not null, primary key
#  name          :string
#  skill_id      :integer
#  points        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  display_alias :integer
#

class ActiveSkill < ActiveRecord::Base
	belongs_to :skill

	has_many :active_skill_aliases

	def self.import
		File.open('./data/active_skills.txt', 'r') do |f|
			f.each_line do |line|
				line.strip!
				line_arr = line.split(',')
				skill_id = Skill.find_by_name(line_arr[1]).id
				ActiveSkill.create(name: line_arr[0], skill_id: skill_id, points: line_arr[2])
			end
		end
	end
end
