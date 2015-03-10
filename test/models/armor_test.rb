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

require 'test_helper'

class ArmorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
