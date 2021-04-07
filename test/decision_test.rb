require "test/unit"
require 'decision'

class RandomDecisionTest < Test::Unit::TestCase

  def setup
    @decision = RandomDecision.new
  end

  def test_takes_any_from_available
    position = Position.new(
      [8, 9, 0, 0, 'x', 0, 9, 0, 9], 40,
      [10, 10, 10, 0, 9, 9, 9, 9, 9], 12)
    available = [0, 1, 6, 8]

    step = @decision.decide(position, 1)

    assert(available.include?(step), "Expected #{available} includes #{step}")
  end
end

class MostProfitableStepDecisionTest < Test::Unit::TestCase

  def setup
    @decision = MostProfitableStepDecision.new
  end

  def test_decision_takes_most_profitable
    position = Position.new(
      [9, 0, 0, 0, 'x', 0, 0, 0, 9], 40,
      [10, 10, 10, 0, 9, 9, 9, 9, 9], 29)
    best_step = 8

    step = @decision.decide(position, 1)

    assert_equal(step, best_step, "Expected best step #{best_step} but was #{step}")
  end

  def test_decision_two_equal_takes_first
    position = Position.new(
      [9, 0, 0, 0, 'x', 0, 9, 0, 9], 40,
      [10, 10, 10, 0, 9, 9, 9, 9, 9], 20)
    first_best_step = 6

    step = @decision.decide(position, 1)

    assert_equal(step, first_best_step, "Expected best step #{first_best_step} but was #{step}")
  end
end