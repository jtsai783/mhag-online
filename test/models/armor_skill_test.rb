# == Schema Information
#
# Table name: armor_skills
#
#  id         :integer          not null, primary key
#  armor_id   :integer
#  skill_id   :integer
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ArmorSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
