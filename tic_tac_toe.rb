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
    
    attr_accessor :blocks
    
    @first_player = 0

    # array to store the actual blocks, don't assign them to a variable just put them here
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

    # method to choose who goes first
    def who_first?
        # get player guesses
        puts "Player 1, guess a number between 1 and 10"
        @guess_one = gets.chomp
        puts "Player 2, guess a number between 1 and 10"
        @guess_two = gets.chomp

        # check the player guessed a number, not a letter or symbol
        begin
            Float(@guess_one)
        rescue ArgumentError => exception
            self.incorrect_input
            return
        else
            @guess_one = @guess_one.to_f
        end
        begin
            Float(@guess_two)
        rescue ArgumentError => exception
            self.incorrect_input
            return
        else
            @guess_two = @guess_two.to_f
        end

        # check the numbers are between 0 and 10
        if @guess_one < 0 || @guess_one > 10 || @guess_two < 0 || @guess_two > 10
            self.incorrect_input
            return
        end

        # declare which is closest
        rand_num = Random.rand(11)
        if (rand_num - @guess_one).abs < (rand_num - @guess_two).abs
            puts "Player 1 goes first"
            @first_player = 1
        elsif (rand_num - @guess_one).abs > (rand_num - @guess_two).abs
            puts "Player 2 goes first"
            @first_player = 2
        else
            puts "It's a tie, try again!"
            self.who_first?
        end
    end

    def incorrect_input
        puts "***Your guess must be a number between 1 and 10***"
        self.who_first?
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
test_board.who_first?