# == Schema Information
#
# Table name: decorations
#
#  id            :integer          not null, primary key
#  name          :string
#  rarity        :integer
#  slots         :integer
#  avail_online  :integer
#  avail_offline :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Decoration < ActiveRecord::Base
	has_many :dec_skills
	has_many :skills, through: :dec_skills

	def self.import
		File.open('./data/dec_final.txt', 'r') do |f|
			f.each_line do |line|
				line.strip!
				line_arr = line.split(',')
				dec = Decoration.create(name: line_arr[0], rarity: line_arr[1], slots: line_arr[2], avail_online: line_arr[3], avail_offline: line_arr[4])
				if !line_arr[5].nil?
					sid = Skill.find_by_name(line_arr[5]).id
					DecSkill.create(skill_id: sid, decoration_id: dec.id, points: line_arr[6])
				end

				if !line_arr[7].nil?
					sid = Skill.find_by_name(line_arr[7]).id
					DecSkill.create(skill_id: sid, decoration_id: dec.id, points: line_arr[8])
				end
			end
		end
	end
end
