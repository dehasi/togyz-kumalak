require "./lib/position"

def render(position)
  puts "P2:#{position.player2.reverse()}"
  puts "Kazan1: #{position.kazan1}          Kazan2: #{position.kazan2}"
  puts "P1:#{position.player1}"
end

puts "Togyz Kumalak!"

position = Position.new
puts render(position)

puts "p1: step 5 -> 4"
position = position.step(1, 4)
puts render(position)

puts "p2: step 1 -> 9"
position =  position.step(2, 0)
puts render(position)

