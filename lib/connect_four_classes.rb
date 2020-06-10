require 'colorize'
#constants for colored circles
RED = "\u2B24".red
GREEN = "\u2B24".green

class Space
    attr_accessor :occupied
    def initialize(occupied = " ")
        @occupied = occupied
    end
end

class Board
    attr_accessor :display, :space_array
    #dynamically creates attributes set to space objects for all 42 spaces
    def initialize
        x = 0
        y = 0
        space_array = []
        42.times do
            space = instance_variable_set("@space#{x}#{y}", Space.new)
            space_array.push(space)
            self.class.send(:attr_accessor, "space#{x}#{y}")
            y += 1
            if y == 6
                y = 0
                x += 1
            end
        end
        @space_array = space_array
        @display = "------------------------------------\n| #{space05.occupied}  | #{space15.occupied}  | #{space25.occupied}  |"\
                " #{space35.occupied}  | #{space45.occupied}  | #{space55.occupied}  | #{space65.occupied}  |\n"\
                "------------------------------------\n| #{space04.occupied}  | #{space14.occupied}  | #{space24.occupied}  |"\
                " #{space34.occupied}  | #{space44.occupied}  | #{space54.occupied}  | #{space64.occupied}  |\n" \
                "------------------------------------\n| #{space03.occupied}  | #{space13.occupied}  | #{space23.occupied}  |"\
                " #{space33.occupied}  | #{space43.occupied}  | #{space53.occupied}  | #{space63.occupied}  |\n"\
                "------------------------------------\n| #{space02.occupied}  | #{space12.occupied}  | #{space22.occupied}  |"\
                " #{space32.occupied}  | #{space42.occupied}  | #{space52.occupied}  | #{space62.occupied}  |\n"\
                "------------------------------------\n| #{space01.occupied}  | #{space11.occupied}  | #{space21.occupied}  |"\
                " #{space31.occupied}  | #{space41.occupied}  | #{space51.occupied}  | #{space61.occupied}  |\n"\
                "------------------------------------\n| #{space00.occupied}  | #{space10.occupied}  | #{space20.occupied}  |"\
                " #{space30.occupied}  | #{space40.occupied}  | #{space50.occupied}  | #{space60.occupied}  |\n"\
                "------------------------------------\n   1    2    3    4    5    6    7"    
    end
    def update_display 
        @display = "------------------------------------\n| #{@space05.occupied}  | #{@space15.occupied}  | #{@space25.occupied}  |"\
        " #{@space35.occupied}  | #{@space45.occupied}  | #{@space55.occupied}  | #{@space65.occupied}  |\n"\
        "------------------------------------\n| #{@space04.occupied}  | #{@space14.occupied}  | #{@space24.occupied}  |"\
        " #{@space34.occupied}  | #{@space44.occupied}  | #{@space54.occupied}  | #{@space64.occupied}  |\n" \
        "------------------------------------\n| #{@space03.occupied}  | #{@space13.occupied}  | #{@space23.occupied}  |"\
        " #{@space33.occupied}  | #{@space43.occupied}  | #{@space53.occupied}  | #{@space63.occupied}  |\n"\
        "------------------------------------\n| #{@space02.occupied}  | #{@space12.occupied}  | #{@space22.occupied}  |"\
        " #{@space32.occupied}  | #{@space42.occupied}  | #{@space52.occupied}  | #{@space62.occupied}  |\n"\
        "------------------------------------\n| #{@space01.occupied}  | #{@space11.occupied}  | #{@space21.occupied}  |"\
        " #{@space31.occupied}  | #{@space41.occupied}  | #{@space51.occupied}  | #{@space61.occupied}  |\n"\
        "------------------------------------\n| #{@space00.occupied}  | #{@space10.occupied}  | #{@space20.occupied}  |"\
        " #{@space30.occupied}  | #{@space40.occupied}  | #{@space50.occupied}  | #{@space60.occupied}  |\n"\
        "------------------------------------\n   1    2    3    4    5    6    7"
    end

end

class Player
    attr_accessor :color
    def initialize(color)
        @color = color
    end

    def take_turn(column)
        column = column.to_i
        index = (column - 1) * 6
        original_index = index
        row = 0
        while index <= (original_index + 5)
            if $board.space_array[index].occupied != " "
                index += 1
                row += 1
            else
                break
            end
        end
        if index == original_index + 6
            return nil
        end
        space_number = ((column - 1) * 10) + row
        space_number = space_number.to_s.rjust(2, "0")
        space = $board.instance_variable_get("@space#{space_number}")
        space.occupied = self.color
        $board.update_display
    end

    def win?
        $board.space_array.each_with_index do |space, index|
            if space.occupied == self.color
                #check horizontal win(index + 6 is next space to the right)
                new_index = index + 6
                in_a_row = 1
                while new_index <= index + 18
                    if $board.space_array[new_index] == nil
                        break
                    elsif $board.space_array[new_index].occupied == self.color
                        new_index += 6
                        in_a_row += 1
                    else
                        break
                    end
                end
                if in_a_row == 4 
                    return true
                end

                #check for vertical win(index + 1 is next space up)
                new_column = [6,12,18,24,30,36]
                new_index = index + 1
                in_a_row = 1
                while new_index <= index + 3
                    if $board.space_array[new_index] == nil
                        break
                    elsif new_column.include?(new_index)
                        break
                    elsif $board.space_array[new_index].occupied == self.color
                        new_index += 1
                        in_a_row += 1
                    else
                        break
                    end
                end
                if in_a_row == 4
                    return true
                end
                
                #check for upwards diagonal win(index + 7 is next space up diagonally)
                new_index = index + 7
                in_a_row = 1
                while new_index <= index + 21
                    if $board.space_array[new_index] == nil
                        break
                    elsif $board.space_array[new_index].occupied == self.color
                        new_index += 7
                        in_a_row += 1
                    else
                        break
                    end
                end
                if in_a_row == 4
                    return true
                end

                #check for downwards diagonal win(index + 5 is next space down diagonally)
                new_index = index + 5
                in_a_row = 1
                while new_index <= index + 15
                    if $board.space_array[new_index] == nil
                        break
                    elsif $board.space_array[new_index].occupied == self.color
                        new_index += 5
                        in_a_row += 1
                    else
                        break
                    end
                end
                if in_a_row == 4
                    return true
                end
                
            end
        end
        return false
    end
end

def draw?
    index = 5
    while index <= 41
        if $board.space_array[index].occupied != " "
            index += 6
        else
            return false
        end
    end
    return true
end

$board = Board.new
red = Player.new(RED)
green = Player.new(GREEN)
