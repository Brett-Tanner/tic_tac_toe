# 2 human players can play against each other on the cmd line, board is displayed in between turns

# TODO: Remember public and private methods exist

# control flow 
    # 1. call create/print combo method 9 times to create 9 numbered rows and store them in the array

    # 1.5 each player picks a random number, the one who's closest to the randomly generated number goes first

    # 2. Ask for the number of the Row O wants to take (only accept if == CONSTANT, otherwise chide them for cheating) 
    # 3. change the column of that Row to O and re-print the board 

    # 4. Ask for the number of the Row X wants to take (only accept if == CONSTANT, otherwise chide them for cheating) 
    # 5. change the column of that Row to X and re-print the board 

    # 6. each time the board is reprinted, check for a winner (e.g if 1 == 2 && 2 == 3, puts winner is #{2.column}, also check the middle one isn't equal to the constant), also check if .all?(!=CONSTANT and if so declare a tie)

# board class 
class Board
    
    attr_accessor :rows
    
    # stores number of turns so you know when the game's over FIXME: Why do these need to be class variables???
    @@num_of_turns = 0

    # array to store the actual rows, don't assign them to a variable just put them here FIXME: Why do these need to be class variables???
    @@rows = []

    # method to create game board
    def create_board
        3.times {|i| @@rows.push(Row.new)}
        self.print_board
    end

    # method to print board
    def print_board
        puts "#{@@rows[0].column.join}"
        puts "#{@@rows[1].column.join}"
        puts "#{@@rows[2].column.join}"
    end

    # method to choose who goes first
    def who_first?
        # get player guesses
        puts "Player O, guess a number between 1 and 10"
        @guess_one = gets.chomp
        puts "Player X, guess a number between 1 and 10"
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
            puts "O goes first"
            self.player_choice("O")
        elsif (rand_num - @guess_one).abs > (rand_num - @guess_two).abs
            puts "X goes first"
            self.player_choice("X")
        else
            puts "It's a tie, try again!"
            self.who_first?
        end
    end

    def incorrect_input
        puts "***Your guess must be a number between 1 and 10***"
        self.who_first?
    end

    def player_choice(player)
        puts "#{player} enter row and column separated by a space (0-2)"
        coordinates = gets.chomp.split
        chosen_row = coordinates[0].to_i
        chosen_column = coordinates[1].to_i
        if chosen_row < 0 || chosen_row > 2 || chosen_column < 0 || chosen_row > 2
            puts "***Coordinates must be between 0 and 2 (inclusive)***"
            player_choice(player)
            return
        end
        # # Set new column if valid move, else ask for input again
        # if @@rows[chosen_row].column != "O" && @@rows[chosen_row].column != "X"
        #     @@rows[chosen_row].column = " #{player} "
        #     @@num_of_turns += 1
        #     self.print_board
        # else
        #     puts "***You can't choose an occupied square!***"
        #     self.player_choice(player)
        # end

        # # end game if 9 turns have passed
        # if @@num_of_turns >= 9
        #     self.game_over
        #     return
        # end
        # # start next turn
        # case player
        # when "O"
        #     self.player_choice("X")
        # when "X"
        #     self.player_choice("O")
        # else
        #     puts "That's not a valid player"
        # end
    end

    def game_over #FIXME: How do I keep score?????
        puts "Result goes here!"
    end

    # method to call the clear method on each Row (then print)
    def reset_game
        # FIXME: claims DEFAULT_COLUMNS is undefined, switching order doesn't solve it
        @@rows.each {|value| value.column = Row.DEFAULT_COLUMNS}
        self.print_board
    end

end

# Row class
class Row
    attr_accessor :column, :DEFAULT_COLUMNS
    
    # CONSTANT for the default columns of a Row
    @@DEFAULT_COLUMNS = [" # ", " # ", " # "]

    def initialize
        @column = @@DEFAULT_COLUMNS
    end

    # variable to store the column of the Row, by default set to CONSTANT

    # method to clear the Row at game end

    # method to add passed columns (X or O)

end

test_board = Board.new
test_board.create_board
test_board.who_first?