require 'pry-byebug'

# TODO: Remember public and private methods exist

# Game class 
class Game
    
    attr_accessor :rows
    
    
    def initialize
        @board = Array.new(3) {Array.new(3, " # ")}
        @num_of_turns = 0
    end

    # method to print board
    def print_board
        3.times { |i| puts @board[i].join}
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
        # Set new column if valid move, else ask for input again
        if @board[chosen_row][chosen_column] != " O " && @board[chosen_row][chosen_column] != " X "
            @board[chosen_row][chosen_column] = " #{player} "
            self.print_board
        else
            puts "***You can't choose an occupied square!***"
            self.player_choice(player)
        end

        # end game if there's a winner or the board is full 
        if self.row_win? || self.diagonal_win? || self.column_win? # ||board_full?
            self.game_over(player)
            return
        end
        
        # start next turn
        case player
        when "O"
            self.player_choice("X")
        when "X"
            self.player_choice("O")
        else
            puts "That's not a valid player"
        end
    end

    def row_win?
        @board.any? { |row| row.all?(" O ") || row.all?(" X ")}
    end

    def column_win?
        first_column = [@board[0][0], @board[1][0], @board[2][0]]
        second_column = [@board[0][1], @board[1][1], @board[2][1]]
        third_column = [@board[0][2], @board[1][2], @board[2][2]]
        if first_column.all?(" O ") || second_column.all?(" O ") || third_column.all?(" O ") || first_column.all?(" X ") || second_column.all?(" X ") || third_column.all?(" X ")
            true
        end
    end

    def diagonal_win?
        top_left = [@board[0][0], @board[1][1], @board[2][2]]
        bottom_left = [@board[2][0], @board[1][1], @board[0][2]]
       if top_left.all?(" O ") || bottom_left.all?(" O ") || top_left.all?(" X ") || bottom_left.all?(" X ")
        true
       end
    end

    def board_full?
        
    end

    def game_over(player)
        puts "#{player} wins!"
    end

    # TODO:
    def reset_game
        
        self.print_board
    end

end

test_game = Game.new
test_game.print_board
test_game.who_first?