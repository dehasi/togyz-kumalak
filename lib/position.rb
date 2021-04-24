#TODO: Add atsyz logic
#TODO: Check if somebody wins

class GameConstant
  HALF = 9
  DESK = 18
  TUZDYK = 'x'
  KUMALAK_COUNT = 81 * 2
end

class Position < GameConstant
  attr_reader :player1, :kazan1, :player2, :kazan2

  def initialize(player1 = Array.new(9, 9), kazan1 = 0, player2 = Array.new(9, 9), kazan2 = 0)
    assert_kumalaks_count(player1, kazan1, player2, kazan2)
    assert_correct_tuzdyk(player1, player2)

    @kazan1 = kazan1
    @player1 = player1
    @kazan2 = kazan2
    @player2 = player2
  end

  private def assert_kumalaks_count(p1, k1, p2, k2)
    raise "Illegal player1 size. Expected #{HALF}; but was #{p1.size}" unless p1.size == HALF
    raise "Illegal player2 size. Expected #{HALF}; but was #{p2.size}" unless p2.size == HALF

    count = p1.select { |k| k != TUZDYK }.sum + p2.select { |k| k != TUZDYK }.sum + k1 + k2
    raise "Impossible kumalaks count. Expected #{KUMALAK_COUNT}; but was #{count}" unless count == KUMALAK_COUNT
  end

  private def assert_correct_tuzdyk(p1, p2)
    raise "Illegal player1 state: tuzdyk at the last otau" unless p1.last != TUZDYK
    raise "Illegal player2 state: tuzdyk at the last otau" unless p2.last != TUZDYK

    t1_count = p1.select { |k| k == TUZDYK }.size
    raise "Illegal player1 state: Expected tuzdyk count 0 or 1; but was #{t1_count}" unless t1_count <= 1
    t2_count = p2.select { |k| k == TUZDYK }.size
    raise "Illegal player2 state: Expected tuzdyk count 0 or 1; but was #{t2_count}" unless t2_count <= 1

    t_index = p1.find_index(TUZDYK)
    unless t_index.nil?
      raise "Illegal state: both players have tuzdyk at #{t_index}" unless p2[t_index] != TUZDYK
    end
  end

  def result
    if kazan1 > 81
      return 1
    end
    if kazan2 > 81
      return 2
    end
    if kazan1 == kazan2 and kazan2 == 81
      return 0
    end
    -1
  end

  def step(player, from)
    if player == 1
      assert_can_step(@player1, from)
      d, k1, k2 = step1(@player1 + @player2, from)
      Position.new(d[0, HALF], @kazan1 + k1, d[HALF, DESK], @kazan2 + k2)
    else
      assert_can_step(@player2, from)
      d, k2, k1 = step1(@player2 + @player1, from)
      Position.new(d[HALF, DESK], @kazan1 + k1, d[0, HALF], @kazan2 + k2)
    end
  end

  def assert_can_step(desk, start)
    message = step_error_message(desk, start)
    unless message.nil?
      raise message
    end
  end

  private def step_error_message(desk, start)
    unless start >= 0 and start < HALF
      return "Illegal step index. Expected [0..8] but was #{start}"
    end
    unless desk[start] != TUZDYK
      return "Illegal step index. Tuzdyk at index #{start}"
    end
    unless desk[start] != 0
      return "Illegal step index. No kumalaks at index #{start}"
    end
    nil
  end

  private def step1(desk, start)
    kumalaks = desk[start]
    raise "Expected kumalaks > 0; but was #{kumalaks}" unless kumalaks > 0
    desk[start] = 0
    to_my_kazan = to_opponent_kazan = 0
    if kumalaks == 1
      nxt = (start + 1) % desk.size
      if desk[nxt] == TUZDYK
        if nxt < HALF
          to_opponent_kazan += 1
        else
          to_my_kazan += 1
        end
      else
        desk[nxt] += 1
      end
      desk, k = take(desk, nxt)
      [desk, to_my_kazan + k, to_opponent_kazan]
    else
      i = start; nxt = -1
      while kumalaks > 0
        nxt = i % DESK
        if desk[nxt] == TUZDYK
          if nxt < HALF
            to_opponent_kazan += 1
          else
            to_my_kazan += 1
          end
        else
          desk[nxt] += 1
        end
        i = i + 1
        kumalaks -= 1
      end

      desk, k = take(desk, nxt)
      [desk, to_my_kazan + k, to_opponent_kazan]
    end
  end

  private def take(desk, point)
    if point < HALF
      return [desk, 0]
    end
    if desk[point] % 2 == 0
      to_kazan = desk[point]
      desk[point] = 0
      return desk, to_kazan
    else
      if desk[point] == 3 and can_be_tuzdyk(desk, point)
        desk[point] = TUZDYK
        to_kazan = 3
        return desk, to_kazan
      else
        return desk, 0
      end
    end
  end

  private def can_be_tuzdyk(desk, point)
    # can't be at my half and at the end
    if point < HALF or point == 17
      return false
    end
    # can't be more than one
    if desk[HALF, DESK].select { |k| k == TUZDYK }.size > 0
      return false
    end
    # can't be at the same index as opponent
    opponent_tuzdyk = desk[0, HALF].find_index(TUZDYK)
    unless opponent_tuzdyk.nil?
      return point != (opponent_tuzdyk + HALF)
    end
    return true
  end

  def to_s
    "{\n\"player1\": #{@player1}, \"kazan1\": #{@kazan1},\n\"player2\": #{@player2}, \"kazan2\": #{@kazan2}\n}"
  end
end

