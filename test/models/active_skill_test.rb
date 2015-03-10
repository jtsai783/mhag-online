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

require 'test_helper'

class ActiveSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
