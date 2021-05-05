require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/game_logic'

def test_game
  test_game = TicTacToeLogic.new
  test_game.play(0, 'X')
  test_game.play(4, 'X')
  test_game.play(1, 'O')
  test_game.play(8, 'O')
  test_game
end
tokens = %w[X O]

RSpec.describe 'Tests for TicTacToeLogic' do
  describe 'Tests for #valid_move?' do
    it 'Is true for unoccupied cell' do
      expect(test_game.valid_move?(2)).to be(true)
    end

    it 'Is false for occupied cell' do
      expect(test_game.valid_move?(1)).to be(false)
    end

    it 'Raises ArgumentError for non-numeric cell identifier' do
      expect { test_game.valid_move?('asd') }.to raise_error(ArgumentError)
    end

    it 'Raises ArgumentError for out-of-bounds cell identifier' do
      expect { test_game.valid_move?(10) }.to raise_error(ArgumentError)
    end
  end

  describe 'Tests for #play' do
    it 'Raises turn counter' do
      expect(test_game.turn).to eq(4)
    end

    it 'Updates board cell when valid move' do
      test = test_game
      expect(test.board.row(2)[0]).to eq(' ')
      test.play(6, 'X')
      expect(test.board.row(2)[0]).to eq('X')
    end

    it 'Returns true when play on a free cell' do
      expect(test_game.play(6, 'X')).to be(true)
    end

    it 'Returns false when play on an occupied cell' do
      expect(test_game.play(0, 'X')).to be(false)
    end
  end

  describe 'Test for #winner' do
    it 'Returs false for ongoing game' do
      expect(test_game.winner(tokens)).to be(false)
    end

    win_row = TicTacToeLogic.new
    3.times { |i| win_row.play(i, 'X') }

    it 'Returns winner token when X wins' do
      expect(win_row.winner(tokens)).to eq('X')
    end

    it 'Returns winner token when win on row' do
      expect(win_row.winner(tokens)).to eq('X')
    end

    win_col = TicTacToeLogic.new
    3.times { |i| win_col.play(3 * i, 'X') }

    it 'Returns winner token when win on col' do
      expect(win_col.winner(tokens)).to eq('X')
    end

    win_diag = TicTacToeLogic.new
    win_diag.play(2, 'O')
    win_diag.play(4, 'O')
    win_diag.play(6, 'O')

    it 'Returns winner token when win on diagonal' do
      expect(win_diag.winner(tokens)).to eq('O')
    end

    it 'Returns winner token when O wins' do
      expect(win_diag.winner(tokens)).to eq('O')
    end

    it 'Returns :tie for tied game' do
      tied_game = test_game
      tied_game.play(2, 'X')
      tied_game.play(3, 'O')
      tied_game.play(5, 'O')
      tied_game.play(6, 'O')
      tied_game.play(7, 'X')
      expect(tied_game.winner(tokens)).to eq(:tie)
    end

    it 'Returns winner token when win on last move' do
      won_last = test_game
      won_last.play(2, 'X')
      won_last.play(5, 'O')
      won_last.play(6, 'X')
      won_last.play(7, 'O')
      won_last.play(3, 'X')
      expect(won_last.winner(tokens)).to eq('X')
    end
  end
end
