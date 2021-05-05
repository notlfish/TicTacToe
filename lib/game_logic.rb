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

  def winner(tokens)
    winner_lines = tokens.map { |token| Array.new(3, token) }
    winner_lines.each do |winner_line|
      winner_token = winner_line[0]
      return winner_token if @board.lines.any?(winner_line)
    end

    return :tie if @turn == 9

    false
  end
end
