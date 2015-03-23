# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alias_id   :integer
#

class Skill < ActiveRecord::Base
	has_many :armor_skills
	has_many :armors, through: :armor_skills

	has_many :active_skills
	has_many :skill_aliases

	has_many :dec_skills
	has_many :decorations, through: :dec_skills

	def current_alias
		if !alias_id.nil?
			SkillAlias.find(self.alias_id)
		else
			self.name
		end
	end

	def self.import_skill
		File.open('./data/skills_final.txt', 'r') do |f|
			f.each_line do |line|
				line.strip!
				Skill.create(name: line)
			end
		end
	end
end
