# == Schema Information
#
# Table name: dec_skills
#
#  id            :integer          not null, primary key
#  skill_id      :integer
#  decoration_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  points        :integer
#

class DecSkill < ActiveRecord::Base
	belongs_to :decoration
	belongs_to :skill
end
