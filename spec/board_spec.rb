require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/board'

map = Board.new(:map)

RSpec.describe 'Tests for Board' do
  describe 'Test for #row' do
    it 'Returns appropriate row' do
      expect(map.row(0)).to eq([1, 2, 3])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.row(4) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #column' do
    it 'Returns appropriate column' do
      expect(map.column(0)).to eq([1, 4, 7])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.column(4) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #diagonal' do
    it 'Returns appropriate diagonal' do
      expect(map.diagonal(0)).to eq([1, 5, 9])
      expect(map.diagonal(2)).to eq([3, 5, 7])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.diagonal(4) }.to raise_error(ArgumentError)
    end
  end

  describe 'Test for #update' do
    it 'Returns updates pointed element' do
      map = Board.new(:map)
      map.update(2, 'X')
      expect(map.row(0)).to eq([1, 2, 'X'])
    end

    it 'Raises ArgumentError for invalid index' do
      expect { map.update(10, nil) }.to raise_error(ArgumentError)
    end
  end
end
