require_relative './board'

class TicTacToeLogic
  attr_reader :board, :turn

  def initialize
    @turn = 0
    @board = Board.new
  end

  def valid_move?(move)
    raise ArgumentError, 'Invalid move' unless (0..8).member?(move)

    @board.available?(move)
  end

  def play(move, token)
    return false unless valid_move?(move)

    @turn += 1
    @board.update(move, token)
    true
  end

  def winner
    return :tie if @turn == 9

    3.times do |i|
      lines = [@board.row(i), @board.column(i), @board.diagonal(i)]
      x_in_line = lines.map { |line| line.count('X') }
      o_in_line = lines.map { |line| line.count('O') }
      return 'X' if x_in_line.max == 3
      return 'O' if o_in_line.max == 3
    end
    false
  end
end
