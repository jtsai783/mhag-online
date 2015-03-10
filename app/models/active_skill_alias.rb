# == Schema Information
#
# Table name: active_skill_aliases
#
#  id              :integer          not null, primary key
#  active_skill_id :integer
#  alias           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ActiveSkillAlias < ActiveRecord::Base
	belongs_to :active_skill
end
