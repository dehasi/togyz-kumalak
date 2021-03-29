
#TODO: Add tuzdyk logic

class Position
  #attr_reader :name, :age
  HALF = 9
  DESK = 18
  def initialize()
    @kazan1 = @kazan2 = 0
    @player1 = Array.new(9,9)
    @player2 = Array.new(9,9)
  end
  
  def initialize(player1, kazan1, player2, kazan2)
    @kazan1 = kazan1
    @player1 = player1
    @kazan2 = kazan2
    @player2 = player2
  end

  def step(player, from)
    #TODO: check if can step
  end

  def to_s
    puts "P2:#{@player2.reverse()}"
    puts "Kazan1: #{@kazan1}          Kazan2: #{@kazan2}"
    puts "P1:#{@player1}"
  end
end
puts "Togyz Kumalak!"


def can_step(desk, start)
	if start < 0 or start > 8 
        return false
    end
    if desk[start] == 'x' or desk[start] == 0
        return false
    end
    return true
end

def finish(desk, point)
    if point <= HALF
        return 0
    else 
        if desk[point]%2 == 0
            return desk[point]
        # else if desk[point] == 3 and no tuzdyk return tuzdyk
        end 
    end 
end
def step(desk, start)
    i = start
    s = desk[]
    if s == 1
        nxt = (i+1)/desk.size()
        if desk[nxt] != 'x'
            desk[nxt] = desk[nxt] + 1
        end
    end
    return desk
end

player = 1
print "p#{player}: "
step = gets.chomp.to_i
puts can_step(player1 + player2, step-1)
puts "step #{step} ->"
puts Position.new.to_s
