class Game
    
  attr_accessor :rows
    
  def initialize
    @board = Array.new(3) {Array.new(3, " # ")}
  end

  public

  def play_game
    who_first()
  end

  def who_first
    # get player guesses 
    o_guess = player_input("Player O, guess a number between 0 and 10").to_i
    x_guess = player_input("Player X, guess a number between 0 and 10").to_i
    
    # check the numbers are between 0 and 10
    if o_guess < 0 || o_guess > 10 || x_guess < 0 || x_guess > 10
      puts "***Your guess must be between 0 and 10***"
      who_first()
      return
    end
    
    # declare which is closest
    rand_num = rand(11)
    o_diff = (rand_num - o_guess).abs
    x_diff = (rand_num - x_guess).abs
    if o_diff < x_diff
      puts "O goes first"
      return "O"
    elsif x_diff < o_diff
      puts "X goes first"
      return "X"
    else
      puts "It's a tie, try again!"
      return who_first()
    end
  end

  private

  def print_board
    3.times { |i| puts @board[i].join}
  end

  def player_input(message)
    puts message
    gets.chomp
  end

  def player_choice(player)
      puts "#{player} enter row and column separated by a space"
    coordinates = gets.chomp.split
    begin
        chosen_row = coordinates[0].to_i - 1
        chosen_column = coordinates[1].to_i - 1
    rescue NoMethodError => exception
        puts "You made a typo"
        player_choice(player)
        return
    end
    if chosen_row < 0 || chosen_row > 2 || chosen_column < 0 || chosen_row > 2
        puts "***Coordinates must be between 1 and 3 (inclusive)***"
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
    if self.row_win? || self.diagonal_win? || self.column_win?
        self.game_over(player)
        return
    elsif self.board_full?
        self.reset_game
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
    @board.all? { |row| row.all? { |column| column != " # "}}
  end

  def game_over(player)
    puts "#{player} wins!"
    self.reset_game
  end

  def reset_game
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp.downcase
    if answer == "y"
        self.initialize
    elsif answer == "n"
        return
    else
        puts "***Please answer 'y' or 'n'***"
        self.reset_game
    end    
  end
end

game = Game.new