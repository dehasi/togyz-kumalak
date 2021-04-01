#TODO: Add tuzdyk logic
#TODO: Add atsyz logic
#TODO: Check if somebody wins

class Position
  attr_reader :player1, :kazan1, :player2, :kazan2

  HALF = 9
  DESK = 18
  TUZDYK = 'x'
  KUMALAK_COUNT = 81 * 2

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
      raise "Illegal state: both players have tuzdyk at #{t_index}" unless p2[t_index] == TUZDYK
    end
  end

  def step(player, from)
    if player == 1
      assert_can_step(@player1, from)
      d, k1, k2 = step1(@player1 + @player2, from)
      Position.new(d[0, HALF], @kazan1 + k1, d[HALF, DESK], @kazan2 + k2)
    else
      assert_can_step(@player2, from)
      # puts "DEBUG #{@player2 + @player1}"
      d, k2, k1 = step1(@player2 + @player1, from)
      # puts "DEBUG #{d}"
      Position.new(d[HALF, DESK], @kazan1 + k1, d[0, HALF], @kazan2 + k2)
    end
  end

  def assert_can_step(desk, start)
    raise "Illegal step index. Expected [0..8] but was #{start}" unless start >= 0 and start < HALF
    raise "Illegal step index. Tuzdyk at index #{start}" unless desk[start] != TUZDYK
    raise "Illegal step index. No kumalaks at index #{start}" unless desk[start] != 0
  end

  private def step1(desk, start)
    kumalaks = desk[start]
    raise "Expected kumalaks > 0; but was #{kumalaks}" unless kumalaks > 0
    desk[start] = 0
    if kumalaks == 1
      nxt = (start + 1) % desk.size
      desk[nxt] = desk[nxt] + 1
      return desk, 0, 0
    end

    i = start; nxt = -1
    while kumalaks > 0
      nxt = i % DESK
      desk[nxt] = desk[nxt] + 1
      i = i + 1
      kumalaks = kumalaks - 1
    end

    desk, k1 = take(desk, nxt)
    # puts "DEBUG: desk #{desk} k1/2#{k1}, nxt #{nxt}"
    [desk, k1, 0]
  end

  private def take(desk, point)
    if point < HALF
      [desk, 0]
    else
      if desk[point] % 2 == 0
        to_kazan = desk[point]
        desk[point] = 0
        return desk, to_kazan
        # else if desk[point] == 3 and no tuzdyk return tuzdyk
      else
        return desk, 0
      end
    end
  end

  def to_s
    "{\n\"player1\": #{@player1}, \"kazan1\": #{@kazan1},\n\"player2\": #{@player2}, \"kazan2\": #{@kazan2}\n}"
  end
end

