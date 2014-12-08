# == Schema Information
#
# Table name: game_states
#
#  id              :integer          not null, primary key
#  state           :integer
#  jam_number      :integer
#  period_number   :integer
#  jam_clock_label :string(255)
#  home_id         :integer
#  away_id         :integer
#  game_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  jam_clock       :integer
#  period_clock    :integer
#

require "test_helper"

describe GameState do
  let(:game_state) { GameState.new }

  it "must be valid" do
    game_state.must_be :valid?
  end
end