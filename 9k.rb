
#TODO: Add tuzdyk logic

class Position
  #attr_reader :name, :age
  HALF = 9
  DESK = 18

  #def initialize()
  #  @kazan1 = @kazan2 = 0
  #  @player1 = Array.new(9,9)
  #  @player2 = Array.new(9,9)
  #end
  
  def initialize(player1=Array.new(9,9), kazan1=0, player2=Array.new(9,9), kazan2=0)
    @kazan1 = kazan1
    @player1 = player1
    @kazan2 = kazan2
    @player2 = player2
  end

  def step(player, from)
    #TODO: check if can step
    if player == 1
      d,k1,k2 = step1(@player1 + @player2, from - 1) 
      return Position.new(d[0, HALF], k1, d[HALF, DESK], k2)
    else
      d,k2,k1 = step1(@player2 + @player1, from - 1) 
      return Position.new(d[HALF, DESK], k2, d[0, HALF], k1)
    end
  end

  private def step1(desk, start)
    #TODO: add kumalaks to kazan
    kumalaks = desk[start]
    desk[start] = 0
    if kumalaks == 1
      nxt = (start + 1) /desk.size()
      desk[nxt] = desk[nxt] + 1
      return desk, 0, 0
    end
    
    i = start
    while kumalaks > 0
      nxt = i % DESK
      desk[nxt] = desk[nxt] + 1
      i = i + 1
      kumalaks = kumalaks - 1
    end
    return desk, 0, 0
  end

  def can_step(desk, start)
	if start < 0 or start > 8 
        return false
    end
    if desk[start] == 'x' or desk[start] == 0
        return false
    end
    return true
  end
  
  def to_s
    puts "P2:#{@player2.reverse()}"
    puts "Kazan1: #{@kazan1}          Kazan2: #{@kazan2}"
    puts "P1:#{@player1}"
  end
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

#player = 1
#print "p#{player}: "
#step = gets.chomp.to_i
#puts can_step(player1 + player2, step-1)
#puts "step #{step} ->"
position =  Position.new
puts "Togyz Kumalak!"
puts position.to_s
puts "step 5 -> "
puts position.step(1, 5).to_s

