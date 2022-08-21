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

    context "A player makes an invalid guess" do
      before do
        allow(game).to receive(:gets).and_return("11", "5", "9", "5")
        allow(game).to receive(:rand).and_return("9")
      end

      xit "displays an error message" do
        error = "***Your guess must be between 0 and 10***"
        expect(game).to receive(:puts).with(error).once
        game.who_first
      end

      xit "still returns the first player" do
        first_player = game.who_first
        expect(first_player).to eql("O")
      end
    end

    context "Both players make an invalid guess" do
      before do
        allow(game).to receive(:gets).and_return("11", "-5", "6", "5")
        allow(game).to receive(:rand).and_return("5")
      end

      xit "displays an error message" do
        error = "***Your guess must be between 0 and 10***"
        expect(game).to receive(:puts).with(error).once
        game.who_first
      end

      xit "still returns the first player" do
        first_player = game.who_first
        expect(first_player).to eql("X")
      end
    end
  end
end