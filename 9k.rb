#!/usr/bin/env ruby

require_relative 'lib/position'
require_relative 'lib/decision'

def render(position)
  puts "P2:#{position.player2.reverse}"
  puts "Kazan1: #{position.kazan1}          Kazan2: #{position.kazan2}"
  puts "P1:#{position.player1}"
end

puts "Togyz Kumalak!"
puts "type exit for exit"
puts ""

decision = MostProfitableStepDecision.new
position = Position.new

def read_line(prompt)
  print prompt
  input = gets
  input ||= ''
  input.chomp
end

def read_step(position)
  while true
    input = read_line("p1>")
    if input == 'exit'
      puts "Bye"
      exit(0)
    end
    step = input.to_i - 1
    if step < 0 or step > 8
      puts "Input should be a one number from 1 to 9"
      next
    end
    case position.player1[step]
    when nil?
      puts "Input should be a one number from 1 to 9"
      next
    when 'x'
      puts "It's the tuzdyk"
      next
    when 0
      puts "No kumalaks"
      next
    else
      return step
    end
  end
end

def opponent(player)
  3 - player # 1 -> 2; 2 -> 1
end

player = 1
while position.result < 0
  puts render(position)
  if player == 1
    step = read_step(position)
  else
    step = decision.decide(position, player)
    puts "p2>#{step + 1}"
  end
  position = position.step(player, step)
  player = opponent(player)

  case position.result
  when 1
    render(position)
    puts "Player 1 won"
    exit(0)
  when 2
    render(position)
    puts "Player 2 won"
    exit(0)
  when 0
    render(position)
    puts "Draw"
    exit(0)
  end
end


