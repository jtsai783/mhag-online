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

require 'test_helper'

class DecorationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
