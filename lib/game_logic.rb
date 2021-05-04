require_relative './board'

class TicTacToeLogic
  attr_reader :board, :turn

  def initialize
    @turn = 0
    @board = Board.new
  end

  def valid_move?(move)
    (0..8).member?(move) && @board.available?(move)
  end

  def play(move, token)
    return false unless valid_move?(move)

    @turn += 1
    @board.update(move, token)
    true
  end

  def winner
    return 'X' if @turn == 5
  end
end
