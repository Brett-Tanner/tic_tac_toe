class Game
    
  attr_accessor :board
    
  def initialize
    @board = Array.new(3) {Array.new(3, " # ")}
    @turn_count = 0
  end

  public

  def play_game
    first_player = who_first()
    # player_turn(first_player)
  end

  def who_first
    # get player guesses 
    o_guess = player_input("Player O, guess a number between 0 and 10").to_i
    x_guess = player_input("Player X, guess a number between 0 and 10").to_i
    
    # check the numbers are between 0 and 10
    if o_guess < 0 || o_guess > 10 || x_guess < 0 || x_guess > 10
      puts "***Your guess must be between 0 and 10***"
      return who_first()
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

  def player_turn(player)
    # get the square player wants to take
    coord = player_input("#{player} enter row and column separated by a space").split
    row = coord[0].to_i - 1
    col = coord[1].to_i - 1

    # check it's a valid move
    return player_turn(player) if out_of_bounds?(row, col) || occupied?(row, col)
    @board[row][col] = " #{player} "
  
    # print the new board and move to next turn or end game
    print_board()
    @turn_count += 1
    return reset_game() if @turn_count >= 9
    game_over?()
    player == "X" ? player_turn("O") : player_turn("X")
  end

  def out_of_bounds?(row, col)
    if row < 0 || row > 2 || col < 0 || row > 2
      puts "***coord must be between 1 and 3 (inclusive)***"
      return true
    end
    false
  end

  def occupied?(row, col)
    return false if @board[row][col] == " # "
    puts "***You can't choose an occupied square!***"
    true
  end

  def game_over?
    return self.end_game(player) if self.row_win? || self.diagonal_win? || self.column_win?
  end

  private

  def print_board
    3.times { |i| puts @board[i].join}
  end

  def player_input(message)
    puts message
    gets.chomp
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

  def end_game(player)
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