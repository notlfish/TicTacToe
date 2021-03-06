#!/usr/bin/env ruby

require_relative '../lib/board'
require_relative '../lib/game_logic'
require 'colorize'

def clear_screen
  Gem.win_platform? ? (system 'cls') : (system 'clear')
end

class TicTacToeUI
  private

  def display_separator(color)
    separator = '+---+---+---+'
    separator = separator.colorize(color) if color
    puts separator
  end

  def color_char(string, char, color)
    string.gsub(char, char.colorize(color))
  end

  def display_row(row, color)
    row_string = "| #{row[0]} | #{row[1]} | #{row[2]} |"
    row_string = color_char(row_string, 'X', @colors[0])
    row_string = color_char(row_string, 'O', @colors[1])
    row_string = color_char(row_string, '|', color) if color
    puts row_string
  end

  def valid_name?(name)
    name.empty? || name[0].match(/^[[:alpha:]]$/)
  end

  def input_names
    2.times do |i|
      puts "Enter Player #{i + 1} name:"
      name = gets.chomp
      unless valid_name?(name)
        puts 'A player name must begin with a letter'
        return init_prompt
      end
      @players[i] = name unless name.empty?
      @players[i] = @players[i].colorize(@colors[i])
    end
  end

  def init_prompt
    puts "Welcome to Serú's Tic-Tac-Toe game"
    input_names
    puts "#{@players[0]} will play #{@tokens[0].colorize(@colors[0])} and "\
         "#{@players[1]} will play #{@tokens[1].colorize(@colors[1])}"
    puts
    puts "Let's play!"
  end

  def play_promt(player, last_input, last_play)
    puts
    puts 'Input a cell index to play' unless last_input
    puts 'That cell is not available!' unless last_play
    puts "It's #{player}'s turn!"
    puts 'Please select an available cell from the board'
    puts
    puts 'The following map indicates the cell identifiers'
    puts
  end

  def play
    last_input = true
    last_play = true
    loop do
      clear_screen
      playing = @game.turn % 2
      display_board(@game.board)
      play_promt(@players[playing], last_input, last_play)
      display_board(@map)
      move = gets.chomp.to_i - 1
      last_input = (0..8).member? move
      if last_input
        last_play = @game.play(move, @tokens[playing])
        return if last_input && last_play
      end
    end
  end

  def win_message(winner)
    @tokens.each_with_index do |token, i|
      next unless winner == token

      clear_screen
      display_board(@game.board, @colors[i])
      puts "#{@players[i]} you won the game!".colorize(@colors[i]) if i < 2
      puts 'Game tied!'.colorize(@colors[i]) if i == 2
    end
  end

  public

  def initialize
    @map = Board.new(:map)
    @players = %w[April Tynnyfer]
    @tokens = ['X', 'O', :tie]
    @colors = %i[green red yellow]
    @game = TicTacToeLogic.new
  end

  def display_board(board, color = nil)
    3.times do |i|
      display_separator(color)
      display_row(board.row(i), color)
    end
    display_separator(color)
  end

  def run!
    clear_screen
    init_prompt
    puts 'Press enter to continue'
    gets
    loop do
      play
      winner = @game.winner(@tokens)
      if winner
        win_message(winner)
        return
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  ui = TicTacToeUI.new
  begin
    ui.run!
  rescue Interrupt
    raise SystemExit
  end
end
