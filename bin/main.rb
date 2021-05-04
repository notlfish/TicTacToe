#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/game_logic'
require 'colorize'

class TicTacToeUI
  def display_separator(color)
    separator = '+---+---+---+'
    separator = separator.colorize(color) if color
    puts separator
  end

  def display_row(row, color)
    row_string = "| #{row[0]} | #{row[1]} | #{row[2]} |"
    row_string = row_string.colorize(color) if color
    puts row_string
  end

  def display_board(board, color = nil)
    3.times do |i|
      display_separator(color)
      display_row(board.row(i), color)
    end
    display_separator(color)
  end

  def initialize
    @map = Board.new(:map)
    @players = %w[April Tynnyfer]
    @tokens = ['X'.colorize(:green), 'O'.colorize(:red)]
    @colors = %i[green red]
    @game = TicTacToeLogic.new
  end

  def init_prompt
    puts "Welcome to Serú's Tic-Tac-Toe game"
    2.times do |i|
      puts "Enter Player #{i + 1} name:"
      name = gets.chomp
      @players[i] = name unless name.empty?
      @players[i] = @players[i].colorize(@colors[i])
    end
    puts "#{@players[0]} will play #{@tokens[0]} and "\
         "#{@players[1]} will play #{@tokens[1]}"
    puts
    puts "Let's play"
  end

  def clear
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end

  def play
    loop do
      clear
      playing = @game.turn % 2
      display_board(@game.board)
      puts
      puts "It's #{@players[playing]}'s turn!"
      puts 'Please select an available cell from the board'
      display_board(@map)
      move = gets.chomp.to_i - 1
      return if @game.play(move, @tokens[playing])
    end
  end

  def win_message(winner)
    case winner
    when 'X'
      clear
      display_board(@game.board, @colors[0])
      puts "#{@players[0]} you won the game!".colorize(@colors[0])
    when 'O'
      clear
      display_board(@game.board, @colors[1])
      puts "#{@players[1]} you won the game!".colorize(@colors[1])
    when :tie
      clear
      display_board(@game.board, :yellow)
      puts 'Game tied!'.colorize(:yellow)
    end
  end

  def run!
    init_prompt
    loop do
      play
      winner = @game.winner
      if winner
        win_message(winner)
        return
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  ui = TicTacToeUI.new
  ui.run!
end
