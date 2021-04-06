#!/usr/bin/env ruby

require_relative 'lib/position'
require_relative 'lib/decision'

def render(position)
  puts "P2:#{position.player2.reverse()}"
  puts "Kazan1: #{position.kazan1}          Kazan2: #{position.kazan2}"
  puts "P1:#{position.player1}"
end

puts "Togyz Kumalak!"

decision = Decision.new
position = Position.new

while position.result < 0
  puts render(position)
  print "p1>"
  input = gets.chomp
  step = input.to_i - 1
  position = position.step(1, step)
  case position.result
  when 1
    puts "Player 1 won"
    next
  when 2
    puts "Player 2 won"
    next
  when 0
    puts "Draw"
    next
  end

  step = decision.decide(position, 2)
  puts "p2>#{step + 1}"
  position = position.step(2, step)

  case position.result
  when 1
    puts "Player 1 won"
    next
  when 2
    puts "Player 2 won"
    next
  when 0
    puts "Draw"
    next
  end
end


