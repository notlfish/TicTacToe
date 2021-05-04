#!/usr/bin/env ruby
require_relative '../lib/game_logic'

class TicTacToeUI
  def display_separator
    puts '+---+---+---+'
  end

  def display_row(row)
    puts "| #{row[0]} | #{row[1]} | #{row[2]} |"
  end

  def display_board(board)
    3.times do |i|
      display_separator
      display_row(board.row(i))
    end
    display_separator
  end

  def initialize; end
end
