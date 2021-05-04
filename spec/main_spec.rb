require 'spec_helper'
require_relative '../bin/main'

class BoardMock
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def row(index)
    @board[index * 3, 3]
  end
end

RSpec.describe 'Tests for TicTacToeUI' do
  describe 'Test for #display_board' do
    it 'Prints "Hello world!" to stdout' do
      message = <<~MSG
        +---+---+---+
        | 1 | 2 | 3 |
        +---+---+---+
        | 4 | 5 | 6 |
        +---+---+---+
        | 7 | 8 | 9 |
        +---+---+---+
      MSG
      expect do
        ui = TicTacToeUI.new
        mock = BoardMock.new
        ui.display_board(mock)
      end.to output(message).to_stdout
    end
  end
end
