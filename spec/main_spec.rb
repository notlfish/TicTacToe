require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/board'

RSpec.describe 'Tests for TicTacToeUI' do
  let(:map_output) do
    <<~OUT
      +---+---+---+
      | 1 | 2 | 3 |
      +---+---+---+
      | 4 | 5 | 6 |
      +---+---+---+
      | 7 | 8 | 9 |
      +---+---+---+
    OUT
  end
  let(:ui) { TicTacToeUI.new }
  let(:mockingboard) { Board.new(:map) }

  describe 'Test for #display_board' do
    it 'Prints example board to stdout' do
      expect { ui.display_board(mockingboard) }.to output(map_output).to_stdout
    end
  end
end
