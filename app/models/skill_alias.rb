# == Schema Information
#
# Table name: skill_aliases
#
#  id         :integer          not null, primary key
#  skill_id   :integer
#  alias      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SkillAlias < ActiveRecord::Base
	belongs_to :skill
end
