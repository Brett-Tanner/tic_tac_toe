# TODO: 2 human players can play against each other on the cmd line, board is displayed in between turns

# control flow 
    # 1. call create/print combo method 9 times to create 9 numbered blocks and store them in the array

    # 1.5 each player picks a random number, the one who's closest to the randomly generated number goes first

    # 2. Ask for the number of the block O wants to take (only accept if == CONSTANT, otherwise chide them for cheating) 
    # 3. change the content of that block to O and re-print the board 

    # 4. Ask for the number of the block X wants to take (only accept if == CONSTANT, otherwise chide them for cheating) 
    # 5. change the content of that block to X and re-print the board 

    # 6. each time the board is reprinted, check for a winner (e.g if 1 == 2 && 2 == 3, puts winner is #{2.content}, also check the middle one isn't equal to the constant), also check if .all?(!=CONSTANT and if so declare a tie)

# board class 
class Board
    # array to store names of blocks (the actual blocks, don't assign them to a variable just put them here)
    @@blocks = []

    # method to create game board
    def create_board
        9.times {|i| @@blocks.push(Block.new)}
    end

    # method to print board
    def print_board
        puts "#{@@blocks[0].content}#{@@blocks[1].content}#{@@blocks[2].content}"
        puts "#{@@blocks[3].content}#{@@blocks[4].content}#{@@blocks[5].content}"
        puts "#{@@blocks[6].content}#{@@blocks[7].content}#{@@blocks[8].content}"
    end

    # method to call the clear method on each block (then print)
    def reset_game
        # FIXME: claims DEFAULT_CONTENTS is undefined, switching order doesn't solve it
        @@blocks.each {|value| value.content = Block.DEFAULT_CONTENTS}
        self.print_board
    end

end

# block class
class Block
    attr_accessor :content, :DEFAULT_CONTENTS
    
    # CONSTANT for the default contents of a block
    @@DEFAULT_CONTENTS = " # "

    def initialize
        @content = @@DEFAULT_CONTENTS
    end

    # variable to store the content of the block, by default set to CONSTANT

    # method to clear the block at game end

    # method to add passed contents (X or O)

end

test_board = Board.new
test_board.create_board
test_board.print_board