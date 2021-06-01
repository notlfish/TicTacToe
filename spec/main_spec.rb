require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/board'

map_output = <<~OUT
  +---+---+---+
  | 1 | 2 | 3 |
  +---+---+---+
  | 4 | 5 | 6 |
  +---+---+---+
  | 7 | 8 | 9 |
  +---+---+---+
OUT

RSpec.describe 'Tests for TicTacToeUI' do
  describe 'Test for #display_board' do
    it 'Prints example board to stdout' do
      expect do
        ui = TicTacToeUI.new
        mock = Board.new(:map)
        ui.display_board(mock)
      end.to output(map_output).to_stdout
    end
  end
end
