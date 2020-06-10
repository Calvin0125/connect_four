#command line game play
#having a separate file allows tests to pass for connect_four_classes
require './lib/connect_four_classes.rb'

puts $board.display
red = Player.new(RED)
green = Player.new(GREEN)
puts "Welcome to Connect Four!"
while true
    puts "Red: Choose a column to play"
    column = gets.chomp
    while column !~ /\A[1234567]\z/
        puts "Enter the number of the column you want to play."
        column = gets.chomp
    end
    space_available = red.take_turn(column)
    while space_available == nil do
        puts "That column is full!\nChoose a different column."
        column = gets.chomp
        while column !~ /\A[1234567]\z/
            puts "Enter the number of the column you want to play."
            column = gets.chomp
        end
        space_available = red.take_turn(column)
    end
    puts $board.display
    if red.win?
        puts "Red won!"
        break
    elsif draw?
        puts "It's a draw."
        break
    end
    puts "Green: Choose a column to play"
    column = gets.chomp
    while column !~ /\A[1234567]\z/
        puts "Enter the number of the column you want to play."
        column = gets.chomp
    end
    space_available = green.take_turn(column)
    while space_available == nil do
        puts "That column is full!\nChoose a different column."
        column = gets.chomp
        while column !~ /\A[1234567]\z/
            puts "Enter the number of the column you want to play."
            column = gets.chomp
        end
        space_available = green.take_turn(column)
    end
    puts $board.display
    if green.win?
        puts "Green won!"
        break
    elsif draw?
        puts "It's a draw."
        break
    end
end