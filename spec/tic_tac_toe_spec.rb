require_relative "../lib/tic_tac_toe.rb"

describe Game do
  subject(:game) {Game.new}

  describe "#who_first" do
    let(:message) {"Player O, guess a number between 0 and 10"}

    before do
      allow(game).to receive(:puts)
    end

    context "Players make valid guesses" do
      before do
        allow(game).to receive(:gets).and_return("5", "8")
      end

      context "player O has the closest guess" do
        before do
          allow(game).to receive(:rand).with(11).and_return(5)
        end

        it "puts 'O goes first'" do
          message = "O goes first"
          expect(game).to receive(:puts).with(message)
          game.who_first
        end

        it "returns O" do
          first_player = game.who_first
          expect(first_player).to eql("O")
        end
      end

      context "player X has the closest guess" do
        before do
          allow(game).to receive(:rand).with(11).and_return(8)
        end

        it "puts 'X goes first'" do
          message = "X goes first"
          expect(game).to receive(:puts).with(message)
          game.who_first
        end

        it "returns X" do
          first_player = game.who_first
          expect(first_player).to eql("X")
        end
      end

      context "players are equally close" do
        before do
          allow(game).to receive(:gets).and_return("9", "1", "8", "5")
          allow(game).to receive(:rand).with(11).and_return(5)
        end

        it "displays an error message" do
          error = "It's a tie, try again!"
          expect(game).to receive(:puts).with(error).once
          game.who_first
        end

        it "asks for new guesses" do
          guess_message = "Player O, guess a number between 0 and 10"
          expect(game).to receive(:puts).with(guess_message).twice
          game.who_first
        end

        it "displays correct message after new guesses" do
          message = "X goes first"
          expect(game).to receive(:puts).with(message)
          game.who_first
        end

        it "returns the correct player after new guesses" do
          first_player = game.who_first
          expect(first_player).to eql("X")
        end
      end
    end

    context "when one player makes an invalid guess" do
      before do
        allow(game).to receive(:gets).and_return("11", "5", "9", "5")
        allow(game).to receive(:rand).and_return(9)
      end

      it "displays an error message" do
        error = "***Your guess must be between 0 and 10***"
        expect(game).to receive(:puts).with(error).once
        game.who_first
      end

      it "still returns the first player" do
        first_player = game.who_first
        expect(first_player).to eql("O")
      end
    end

    context "when both players make an invalid guess" do
      before do
        allow(game).to receive(:gets).and_return("11", "-5", "6", "5")
        allow(game).to receive(:rand).and_return(5)
      end

      it "displays an error message" do
        error = "***Your guess must be between 0 and 10***"
        expect(game).to receive(:puts).with(error).once
        game.who_first
      end

      it "still returns the first player" do
        first_player = game.who_first
        expect(first_player).to eql("X")
      end
    end
  end

  describe "#occupied?" do

    before do
      game.board = [" # ", " # ", " # "], [" X ", " X ", " X "], [" O ", " O ", " O "]
    end

    context "square is unoccupied" do
      
      it "returns false" do
        row = 0
        col = 0
        occupied = game.occupied?(row, col)
        expect(occupied).to be false
      end

      it "doesn't display an error" do
        rwo = 0
        col = 0
        error = "***You can't choose an occupied square!***"
        expect(game).not_to receive(:puts).with(error)
      end
    end

    context "square is occupied" do
      
      before do
        allow(game).to receive(:puts)
      end

      it "returns true" do
        row = 1
        col = 1
        occupied = game.occupied?(row, col)
        expect(occupied).to be true
      end

      it "displays an error" do
        row = 1
        col = 1
        error = "***You can't choose an occupied square!***"
        expect(game).to receive(:puts).with(error).once
        game.occupied?(row, col)
      end
    end
  end

  describe "#out_of_bounds?" do
    
    before do
      allow(game).to receive(:puts)
    end

    context "if coordinates too high" do
      
      it "displays an error message" do
        row = 3
        col = 10
        error = "***Row/col must be 1, 2 or 3***"
        expect(game).to receive(:puts).with(error).once
        game.out_of_bounds?(row, col)
      end
      
      it "returns true" do
        row = 3
        col = 10
        out_of_bounds = game.out_of_bounds?(row, col)
        expect(out_of_bounds).to eql(true)
      end
    end

    context "if coordinates too low" do
      it "displays an error message" do
        row = -1
        col = -10
        error = "***Row/col must be 1, 2 or 3***"
        expect(game).to receive(:puts).with(error).once
        game.out_of_bounds?(row, col)
      end
      
      it "returns true" do
        row = -3
        col = -10
        out_of_bounds = game.out_of_bounds?(row, col)
        expect(out_of_bounds).to eql(true)
      end
    end

    context "if only one coordinate is incorrect" do
      it "displays an error message" do
        row = 3
        col = 1
        error = "***Row/col must be 1, 2 or 3***"
        expect(game).to receive(:puts).with(error).once
        game.out_of_bounds?(row, col)
      end
      
      it "returns true" do
        row = 3
        col = 1
        out_of_bounds = game.out_of_bounds?(row, col)
        expect(out_of_bounds).to eql(true)
      end
    end

    context "if both row & col in bounds" do
      it "returns false" do
        row = 0
        col = 2
        out_of_bounds = game.out_of_bounds?(row, col)
        expect(out_of_bounds).to eql(false)
      end

      it "doesn't display an error" do
        row = 0
        col = 2
        error = "***Row/col must be 1, 2 or 3***"
        expect(game).not_to receive(:puts).with(error)
        game.out_of_bounds?(row, col)
      end
    end
  end

  describe "#game_over?" do
    
    context "when game is over" do

      context "when a row is full" do
      
        before do
          game.board = [" # ", " # ", " # "], [" # ", " X ", " # "], [" O ", " O ", " O "]
        end
  
        it "returns true" do
          game_over = game.game_over?
          expect(game_over).to be true
        end
      end
  
      context "when a column is full" do
        
        before do
          game.board = [" # ", " X ", " # "], [" # ", " X ", " # "], [" # ", " X ", " O "]
        end
  
        it "returns true" do
          game_over = game.game_over?
          expect(game_over).to be true
        end
      end
  
      context "when a diagonal is full" do
        
        before do
          game.board = [" O ", " # ", " # "], [" # ", " O ", " # "], [" X ", " # ", " O "]
        end
  
        it "returns true" do
          game_over = game.game_over?
          expect(game_over).to be true
        end
      end
    end

    context "when the game isn't over" do
      
      before do
        game.board = [" O ", " X ", " # "], [" # ", " X ", " # "], [" O ", " O ", " X "]
      end

      it "returns false" do
        game_over = game.game_over?
        expect(game_over).to be false
      end
    end
  end

  describe "#player_turn" do
   
    # need to stub input here
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return("1 1", "1 2", "1 3", "2 1", "2 2", "2 3", "3 1", "3 2", "3 3")
    end

    it "calls print_board" do
      expect(game).to receive(:print_board).exactly(9).times
      game.player_turn("X")
    end

    xit "calls reset_game" do
      expect(game).to receive(:reset_game).once
      game.player_turn("O")
    end
    
    context "when player is X" do
     
      xit "asks X for coordinates 5 times" do
        
      end

      xit "asks O for coordinates 4 times" do
        
      end
    end

    context "when player is O" do
      before do
        
      end

      xit "asks O for coordinates 5 times" do
        
      end

      xit "asks X for coordinates 4 times" do
        
      end
    end

    before do
      game.board = [" # ", " # ", " # "], [" # ", " X ", " # "], [" O ", " O ", " O "]
    end

    context "if O wins" do

      before do
        game.board = [" # ", " # ", " # "], [" # ", " X ", " # "], [" O ", " O ", " O "]
      end

      xit "displays 'O wins'" do
      
      end
    end

    context "if X wins" do

      before do
        game.board = [" # ", " X ", " # "], [" # ", " X ", " # "], [" O ", " X ", " O "]
      end

      xit "displays 'X wins'" do
      
      end
    end
  end

  
end