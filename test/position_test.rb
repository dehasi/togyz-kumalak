require "test/unit"
require 'decision'

class PositionTest < Test::Unit::TestCase

  def setup
    @decision = RandomDecision.new
  end

  def  test_step_9_to_1_takes_kumalaks
    position = Position.new(
      ["x", 0, 2, 4, 0, 0, 1, 0, 1], 76,
      [1, 1, 2, "x", 2, 2, 2, 1 ,0], 67) # [0, 1, 2, 2, 2, "x", 2, 1, 1]

    position = position.step(1, 8)

    assert_equal(78, position.kazan1)
    assert_equal(["x", 0, 2, 4, 0, 0, 1, 0, 0], position.player1)
    assert_equal([0, 1, 2, "x", 2, 2, 2, 1 ,0], position.player2)
    assert_equal(67, position.kazan2)
  end
end