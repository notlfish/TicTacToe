require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/board'

RSpec.describe 'Tests for Board' do
  let(:map) { Board.new(:map) }

  describe 'Test for #row' do
    it 'Returns appropriate row' do
      expect(map.row(0)).to eq(%w[1 2 3])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.row(4) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #update' do
    it 'Updates pointed element' do
      map.update(2, 'X')
      expect(map.row(0)).to eq(%w[1 2 X])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.update(10, nil) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #available?' do
    let(:board) do
      board = Board.new
      board.update(2, 'X')
      board
    end

    it 'True for available cell' do
      expect(board.available?(0)).to be(true)
    end

    it 'False for occupied cell' do
      expect(board.available?(2)).to be(false)
    end

    it 'Raises ArgumentError for invalid index' do
      expect { board.available?(10) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #lines' do
    let(:lines) do
      [%w[1 2 3], %w[4 5 6], %w[7 8 9],
       %w[1 4 7], %w[2 5 8], %w[3 6 9],
       %w[1 5 9], %w[3 5 7]]
    end

    it 'Returns all of the lines of the board' do
      expect(lines.all? { |line| map.lines.member? line }).to be(true)
    end

    it 'Returns only lines of the board' do
      expect(map.lines.all? { |map_line| lines.member? map_line }).to be(true)
    end
  end
end
