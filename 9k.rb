puts "Togyz Kumalak!"
# nums = [9,9,9,9,'x',9,9,9,9]

player1 = Array.new(9,9)
player2 = Array.new(9,9)
kazan1 = kazan2 = 0


puts "P2:#{player2.reverse()}"
puts "Kazan1: #{kazan1}          Kazan2: #{kazan2}"
puts "P1:#{player1}"

player = 1
print "p#{player}: "
step = gets.chomp.to_i
puts "step #{step} ->"
