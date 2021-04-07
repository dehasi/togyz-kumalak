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
      return position.player1, position.kazan1
    else
      return position.player2, position.kazan1
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
    #puts "DEBUG: available #{available} kazan #{kazan}"
    best_step = available.first
    _, best_kazan = half(position.step(player, best_step), position)

    #puts "DEBUG: initially best step #{best_step} kazan #{best_kazan}"
    available.each { |step|
      _, k = half(player, position.step(player, step))
      #puts "DEBUG: candidate step #{step} kazan #{k}"
      if k > best_kazan
        best_step = step
        best_kazan = k
        #puts "DEBUG: take best step #{best_step} kazan #{best_kazan}"
      end
    }
    best_step
  end

  private

  def opponent(player)
    3 - player # 1 -> 2; 2 -> 1
  end
end