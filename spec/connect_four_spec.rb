require './lib/connect_four_classes.rb'

class Board describe do
    it "space00 should exist and be set to space" do
        $board = Board.new
        expect($board.space00.occupied).to eql(" ")
    end

    it "space33 should exist and be set to space" do
        $board = Board.new
        expect($board.space33.occupied).to eql(" ")
    end
    it "space 65 should exist and be set to space" do
        $board = Board.new
        expect($board.space65.occupied).to eql(" ")
    end
end
end

class Player describe do
    describe "#take_turn" do
        it "puts the first piece in a column" do
            $board = Board.new
            player = Player.new(RED)
            player.take_turn("1")
            expect($board.space00.occupied).to eql(RED)
        end

        it "puts pieces on top of existing pieces" do
            $board = Board.new
            player = Player.new(GREEN)
            $board.space10.occupied = RED
            player.take_turn("2")
            expect($board.space11.occupied).to eql(GREEN)
        end
        it "returns nil if a column is full" do
            $board = Board.new
            player = Player.new(GREEN)
            $board.space20.occupied = RED
            $board.space21.occupied = GREEN
            $board.space22.occupied = RED
            $board.space23.occupied = GREEN
            $board.space24.occupied = RED
            $board.space25.occupied = GREEN
            expect(player.take_turn("3")).to eql(nil)
        end
    end

    describe "win?" do
        it "returns true for vertical win" do
            $board = Board.new
            player = Player.new(RED)
            $board.space00.occupied = RED
            $board.space01.occupied = RED
            $board.space02.occupied = RED
            $board.space03.occupied = RED
            expect(player.win?).to eql(true)
        end

        it "returns true for horizontal win" do
            $board = Board.new
            player = Player.new(GREEN)
            $board.space02.occupied = GREEN
            $board.space12.occupied = GREEN
            $board.space22.occupied = GREEN
            $board.space32.occupied = GREEN
            expect(player.win?).to eql(true)
        end

        it "returns true for upwards diagonal win" do
            $board = Board.new
            player = Player.new(RED)
            $board.space00.occupied = RED
            $board.space11.occupied = RED
            $board.space22.occupied = RED
            $board.space33.occupied = RED
            expect(player.win?).to eql(true)
        end

        it "returns true for downwards diagonal win" do
            $board = Board.new
            player = Player.new(GREEN)
            $board.space15.occupied = GREEN
            $board.space24.occupied = GREEN
            $board.space33.occupied = GREEN
            $board.space42.occupied = GREEN
            expect(player.win?).to eql(true)
        end
        
        it "returns false for 4 in a row that go from one column to the next" do
            $board = Board.new
            player = Player.new(GREEN)
            $board.space05.occupied = GREEN
            $board.space10.occupied = GREEN
            $board.space11.occupied = GREEN
            $board.space12.occupied = GREEN
            expect(player.win?).to eql(false)
        end

        it "returns false if nobody won yet" do
            $board = Board.new
            player = Player.new(RED)
            $board.space00.occupied = RED
            $board.space01.occupied = GREEN
            $board.space10.occupied = RED
            $board.space30.occupied = GREEN
            expect(player.win?).to eql(false)
        end
        
        it "returns false in the event of a draw" do
            $board = Board.new
            player = Player.new(RED)
            $board.space_array.each do |space|
                space.occupied = true
            end
            expect(player.win?).to eql(false)
        end
    end
end
end

describe "#draw?" do
    #draw? does not have check for win because I will always call #win? before #draw?
    it "returns true if board is full" do
        $board = Board.new
        player = Player.new(RED)
        $board.space_array.each do |space|
            space.occupied = true
        end
        expect(draw?).to eql(true)
    end

    it "returns false if game is still in progress" do
        $board = Board.new
        $board.space00.occupied = RED
        $board.space10.occupied = GREEN
        expect(draw?).to eql(false)
    end
end