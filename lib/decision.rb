require_relative 'position'
class Decision

  HALF = 9
  DESK = 18
  TUZDYK = 'x'
  KUMALAK_COUNT = 81 * 2

  def decide(position, player)
    desc = if player == 1
             position.player1
           else
             position.player2
           end

    (0...HALF).select { |k|
      desc[k] != TUZDYK and desc[k] > 0
    }.sample(1).first
  end
end