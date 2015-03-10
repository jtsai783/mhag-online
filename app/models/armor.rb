# == Schema Information
#
# Table name: armors
#
#  id             :integer          not null, primary key
#  name           :string
#  sex            :integer
#  klass          :integer
#  rarity         :integer
#  slots          :integer          default("0"), not null
#  avail_online   :integer
#  avail_offline  :integer
#  initial_def    :integer
#  final_def      :integer
#  fire_resist    :integer
#  water_resist   :integer
#  thunder_resist :integer
#  ice_resist     :integer
#  dragon_resist  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  armor_type     :string
#

class Armor < ActiveRecord::Base
	belongs_to :user
	has_many :armor_skills
	has_many :skills, through: :armor_skills

	def self.verify
		arm_file = File.open('./data/arms_final.txt', 'r')
		body_file = File.open('./data/body_final.txt', 'r')
		head_file = File.open('./data/head_final.txt', 'r')
		legs_file = File.open('./data/legs_final.txt', 'r')
		waist_file = File.open('./data/waist_final.txt', 'r')
		file_arr = [arm_file, body_file, head_file, legs_file, waist_file]

		file_arr.each do |file|
			file.each_line do |line|
				line.strip!
				line_arr = line.split(',')
				(1..5).each do |i|
					if line_arr[13+2*i].to_i.abs > 0 && line_arr[13+2*i-1].length == 0
						p line
					end
				end
			end
		end

		arm_file.close
		body_file.close
		head_file.close
		legs_file.close
		waist_file.close
	end

	def self.import_arm


		arm_file = File.open('./data/arms_final.txt', 'r')
		body_file = File.open('./data/body_final.txt', 'r')
		head_file = File.open('./data/head_final.txt', 'r')
		legs_file = File.open('./data/legs_final.txt', 'r')
		waist_file = File.open('./data/waist_final.txt', 'r')

		arm_file.each_line do |line|
			line.strip!
			line_arr = line.split(',')
			armor = Armor.create(
				armor_type: 'a',
				name: line_arr[0],
				sex: line_arr[1],
				klass: line_arr[2],
				rarity: line_arr[3],
				slots: line_arr[4],
				avail_online: line_arr[5],
				avail_offline: line_arr[6],
				initial_def: line_arr[7],
				final_def: line_arr[8],
				fire_resist: line_arr[9],
				water_resist: line_arr[10],
				thunder_resist: line_arr[11],
				ice_resist: line_arr[12],
				dragon_resist: line_arr[13]
				)
			(1..5).each do |i|
				if line_arr[13+2*i-1].length != 0
					sid = Skill.find_by_name(line_arr[13+2*i-1]).id
					ArmorSkill.create(skill_id: sid, armor_id: armor.id, points: line_arr[13+2*i].to_i)
				end
			end
		end

		arm_file.close
		body_file.close
		head_file.close
		legs_file.close
		waist_file.close
	end

	def self.import_body

		body_file = File.open('./data/body_final.txt', 'r')


		body_file.each_line do |line|
			line.strip!
			line_arr = line.split(',')
			armor = Armor.create(
				armor_type: 'b',
				name: line_arr[0],
				sex: line_arr[1],
				klass: line_arr[2],
				rarity: line_arr[3],
				slots: line_arr[4],
				avail_online: line_arr[5],
				avail_offline: line_arr[6],
				initial_def: line_arr[7],
				final_def: line_arr[8],
				fire_resist: line_arr[9],
				water_resist: line_arr[10],
				thunder_resist: line_arr[11],
				ice_resist: line_arr[12],
				dragon_resist: line_arr[13]
				)
			(1..5).each do |i|
				if line_arr[13+2*i-1].length != 0
					sid = Skill.find_by_name(line_arr[13+2*i-1]).id
					ArmorSkill.create(skill_id: sid, armor_id: armor.id, points: line_arr[13+2*i].to_i)
				end
			end
		end
		body_file.close
	end

	def self.import_legs

		legs_file = File.open('./data/legs_final.txt', 'r')


		legs_file.each_line do |line|
			line.strip!
			line_arr = line.split(',')
			armor = Armor.create(
				armor_type: 'l',
				name: line_arr[0],
				sex: line_arr[1],
				klass: line_arr[2],
				rarity: line_arr[3],
				slots: line_arr[4],
				avail_online: line_arr[5],
				avail_offline: line_arr[6],
				initial_def: line_arr[7],
				final_def: line_arr[8],
				fire_resist: line_arr[9],
				water_resist: line_arr[10],
				thunder_resist: line_arr[11],
				ice_resist: line_arr[12],
				dragon_resist: line_arr[13]
				)
			(1..5).each do |i|
				if line_arr[13+2*i-1].length != 0
					sid = Skill.find_by_name(line_arr[13+2*i-1]).id
					ArmorSkill.create(skill_id: sid, armor_id: armor.id, points: line_arr[13+2*i].to_i)
				end
			end
		end
		legs_file.close
	end

	def self.import_head

		head_file = File.open('./data/head_final.txt', 'r')


		head_file.each_line do |line|
			line.strip!
			line_arr = line.split(',')
			armor = Armor.create(
				armor_type: 'h',
				name: line_arr[0],
				sex: line_arr[1],
				klass: line_arr[2],
				rarity: line_arr[3],
				slots: line_arr[4],
				avail_online: line_arr[5],
				avail_offline: line_arr[6],
				initial_def: line_arr[7],
				final_def: line_arr[8],
				fire_resist: line_arr[9],
				water_resist: line_arr[10],
				thunder_resist: line_arr[11],
				ice_resist: line_arr[12],
				dragon_resist: line_arr[13]
				)
			(1..5).each do |i|
				if line_arr[13+2*i-1].length != 0
					sid = Skill.find_by_name(line_arr[13+2*i-1]).id
					ArmorSkill.create(skill_id: sid, armor_id: armor.id, points: line_arr[13+2*i].to_i)
				end
			end
		end
		head_file.close
	end

	def self.import_waist

		waist_file = File.open('./data/waist_final.txt', 'r')


		waist_file.each_line do |line|
			line.strip!
			line_arr = line.split(',')
			armor = Armor.create(
				armor_type: 'w',
				name: line_arr[0],
				sex: line_arr[1],
				klass: line_arr[2],
				rarity: line_arr[3],
				slots: line_arr[4],
				avail_online: line_arr[5],
				avail_offline: line_arr[6],
				initial_def: line_arr[7],
				final_def: line_arr[8],
				fire_resist: line_arr[9],
				water_resist: line_arr[10],
				thunder_resist: line_arr[11],
				ice_resist: line_arr[12],
				dragon_resist: line_arr[13]
				)
			(1..5).each do |i|
				if line_arr[13+2*i-1].length != 0
					sid = Skill.find_by_name(line_arr[13+2*i-1]).id
					ArmorSkill.create(skill_id: sid, armor_id: armor.id, points: line_arr[13+2*i].to_i)
				end
			end
		end
		waist_file.close
	end
end
