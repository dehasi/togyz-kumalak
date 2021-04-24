require_relative 'position'

class Decision < GameConstant

  def decide(position, player)
    raise 'implement me'
  end

  protected

  def available(half)
    (0...HALF).select { |k| half[k] != TUZDYK and half[k] > 0 }
  end

  def half(player, position)
    if player == 1
      [position.player1, position.kazan1]
    else
      [position.player2, position.kazan2]
    end
  end
end

class RandomDecision < Decision
  def decide(position, player)
    half, _ = half(player, position)

    available(half).sample(1).first
  end
end

class MostProfitableStepDecision < Decision

  def decide(position, player)
    half, _ = half(player, position)
    available = available(half)

    best_steps = available.sample(1)
    _, best_kazan = half(position.step(player, best_steps.first), position)

    available.each do |step|
      _, k = half(player, position.step(player, step))
      if k > best_kazan
        best_steps = [step]
        best_kazan = k
        next
      end
      if k == best_kazan
        best_steps << step
        next
      end
    end
    best_steps.sample(1).first
  end
end