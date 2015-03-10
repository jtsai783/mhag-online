module Api
	class SetsController < ApplicationController
		def show
			skill_hash = build_skill_hash
			
			@set_list = []
			if skill_hash != {}
				neg_armor_arr = get_neg_armor_id(skill_hash)
				if !params["banList"].nil?
					neg_armor_arr = neg_armor_arr.concat(params["banList"])
				end
				seed_armors = get_seed_armor(skill_hash, neg_armor_arr)
				seed_armor_index = 0
				seed_armor_length = seed_armors.length
				charm_arr = JSON.parse(params["charm"])
				while @set_list.length < 20 && seed_armor_index < seed_armor_length
					current_set = Hash.new
					current_set["weapon"] = Armor.new(slots: 0)
					current_set["t"] = Armor.new(slots: charm_arr[0])
					running_total = Hash.new(0)
					current_decs = Hash.new { |h, k| h[k] = [] }
					charm_arr.each_with_index do |skill, index|
						if index > 0
							running_total[skill[0]] += skill[1]
						end
					end
					File.open('./log2.txt', 'a') do |f|
						f.puts running_total.inspect
					end
					seed_armor = seed_armors[seed_armor_index]
					fit_armor(current_set, seed_armor)
					File.open('./log2.txt', 'a') do |f|
						f.puts seed_armor.inspect
					end
					add_armor_to_total(running_total, seed_armor)
					File.open('./log2.txt', 'a') do |f|
						f.puts running_total.inspect
					end
					get_armor_set(running_total, skill_hash, current_set, neg_armor_arr)
					dec_list = dec_armor_set(running_total, skill_hash, current_set, current_decs)
					dec_name_hash = dec_id_to_name(dec_list)
					skill_name_hash = skill_id_to_name(running_total)
					if !set_include?(@set_list, current_set)
						@set_list << {set: current_set, total: skill_name_hash, dec: dec_name_hash}
					end
					seed_armor_index += 1
				end
			end
			render json: @set_list
		end

		def build_skill_hash
			skill_hash = Hash.new
			if !params["skillSelects"].nil?
				params["skillSelects"].each do |skill|
					skill = ActiveSkill.find(skill)
					skill_hash[skill.skill_id] = skill.points
				end
			end
			skill_hash
		end

		def skill_id_to_name(running_total)
			name_hash = Hash.new
			running_total.each do |k,v|
				name_hash[Skill.find(k).name] = v
			end
			name_hash = name_hash.sort_by {|k,v| -v}
		end

		def dec_id_to_name(dec_list)
			name_hash = Hash.new
			dec_list.each do |k,v|
				name_hash[Decoration.find(k).name] = v
			end
			name_hash = name_hash.sort_by {|k,v| -v}
		end

		def set_include?(set_list, current_set)
			flag = false
			set_list.each do |set_list_item|
				if set_list_item[:set]['h'].name == current_set['h'].name &&
					set_list_item[:set]['b'].name == current_set['b'].name &&
					set_list_item[:set]['a'].name == current_set['a'].name &&
					set_list_item[:set]['w'].name == current_set['w'].name &&
					set_list_item[:set]['l'].name == current_set['l'].name
					flag = true
				end
			end
			flag
		end

		def dec_armor_set(total, skill_hash, current_set, dec_hash)
			ban_list = []
			dec_agg = Hash.new{|h, k| h[k] = 0}
			while true
				next_skill = calculate_next_skill(total, skill_hash, ban_list)
				break if next_skill == nil
				max = max_avalible_slots(current_set, dec_hash)
				dec_list = get_decs(next_skill, max)
				if dec_list.length == 0
					ban_list << next_skill
				else
					next_dec = choose_next_dec(dec_list, next_skill, skill_hash, total)
					location = find_piece_to_dec(current_set, dec_hash, next_dec)
					dec_hash[location] << next_dec
					dec_agg[next_dec.id] += 1
					add_dec_to_total(total, next_dec)
				end
			end
			dec_agg
		end

		def add_dec_to_total(total, next_dec)
			next_dec.dec_skills.each do |dec_skill|
				total[dec_skill.skill_id] += dec_skill.points
			end
		end

		def find_piece_to_dec(current_set, dec_hash, next_dec)
			min = nil
			loc = nil
			current_set.each do |location, armor|
				diff = armor.slots - sum_slots(dec_hash[location])
				if diff >= next_dec.slots
					if min == nil
						min = diff
						loc = location
					elsif min > diff
						min = diff
						loc = location
					end
				end
			end
			loc
		end

		def choose_next_dec(dec_list, next_skill, skill_hash, total)
			dec_list = dec_list.sort_by do |dec|
				efficiency = dec.dec_skills.find_by_skill_id(next_skill).points.to_f / dec.slots.to_f
				-efficiency
			end
			min = nil
			next_dec = nil
			dec_list.each do |dec|
				diff = skill_hash[next_skill] - (total[next_skill] + dec.dec_skills.find_by_skill_id(next_skill).points)
				if min == nil
					min = diff.abs
					next_dec = dec
				elsif min > diff.abs
					min = diff.abs
					next_dec = dec
				end
			end
			next_dec
		end

		def max_avalible_slots(current_set, dec_hash)
			max = 0
			current_set.each do |location, armor|
				diff = armor.slots - sum_slots(dec_hash[location])
				if diff > max
					max = diff
				end
			end
			max
		end

		def sum_slots(dec_arr)
			sum = 0
			dec_arr.each do |dec|
				sum += dec.slots
			end
			sum
		end

		def get_armor_set(running_total, skill_hash, current_set, neg_armor_arr)
			set_arr = ['h', 'b', 'a', 'w', 'l', 't']
			while (set_arr - current_set.keys).length > 0
				next_skill = calculate_next_skill(running_total, skill_hash, [])
				if !next_skill.nil?
					next_armor = get_armor(next_skill, current_set, neg_armor_arr)
				else
					next_armor = nil
				end
				if next_armor.nil?
					diff = set_arr - current_set.keys
					next_armor = Armor.new(name: "Any 3 Slot", slots: 3, armor_type: diff[0])
				end
				fit_armor(current_set, next_armor)
				add_armor_to_total(running_total, next_armor)
			end
		end

		def fit_armor(current_set, armor)
			current_set[armor.armor_type] = armor
		end

		def calculate_next_skill(running_total, skill_hash, ban_list)
			max = 0
			skill = nil
			skill_hash.each do |k, v|
				if !ban_list.include? k
					diff = v - running_total[k]
					if diff > max
						max = diff
						skill = k
					end
				end
			end
			skill
		end

		def add_armor_to_total(running_total, armor)
			armor.armor_skills.each do |armor_skill|
				running_total[armor_skill.skill_id] += armor_skill.points
			end
		end

		def get_armor(skill, current_set, neg_armor_list)
			join_str = <<-sql
			INNER JOIN armor_skills
			ON armor_skills.skill_id = #{skill}
			AND armor_skills.points >= 0
			AND armors.id = armor_skills.armor_id
			sql
			armor_list = Armor.select("armors.*")
			.joins(join_str)
			.group('armors.id')
			.having('sum(points) + armors.slots * 1.1 > 3 * 1.1')
			.order('sum(points) + armors.slots * 1.1 DESC')
			.where.not(armor_type: current_set.keys)
			.where.not(id: neg_armor_list)
			.where(klass: [0, 1])
			.first
		end

		def get_decs(skill, max)
			join_str = <<-sql
			INNER JOIN dec_skills
			ON dec_skills.skill_id = #{skill}
			AND dec_skills.points >= 0
			AND decorations.id = dec_skills.decoration_id
			sql
			dec_list = Decoration.select("decorations.*")
			.joins(join_str)
			.order('points')
			.where("slots <= #{max}")
		end

		def get_seed_armor(skill_hash, neg_armor_list)
			skill_str = skill_hash.keys.join(',')
			join_str = <<-sql
			INNER JOIN armor_skills
			ON armor_skills.skill_id IN (#{skill_str})
			AND armor_skills.points > 0
			AND armors.id = armor_skills.armor_id
			sql
			armor_list = Armor.select("armors.*")
			.joins(join_str)
			.group('armors.id')
			.having('sum(points) + armors.slots * 1.1 > 3 * 1.1')
			.order('sum(points) + armors.slots * 1.1 DESC')
			.where.not(id: neg_armor_list)
			.where(klass: [0, 1])
		end

		def get_neg_armor_id(skill_hash)
			skill_str = skill_hash.keys.join(',')
			join_str = <<-sql
			INNER JOIN armor_skills
			ON armor_skills.skill_id IN (#{skill_str})
			AND armor_skills.points < 0
			AND armors.id = armor_skills.armor_id
			sql
			neg_armor_list = Armor.select("armors.*")
			.joins(join_str)
			.where(klass: [0, 1])
			.pluck('armors.id')
		end

		def print(set)
			set[:set].each do |loc, armor|
				p loc
				p armor.name
				armor.armor_skills.each do |armor_skill|
					p Skill.find(armor_skill.skill_id).name
					p armor_skill.points
				end
				p set[:dec][loc]
			end
		end
	end
end