require 'spec_helper'
require_relative '../bin/main'
require_relative '../lib/game_logic'

RSpec.describe 'Tests for TicTacToeLogic' do
  describe 'Empty test case' do
    it 'Succeeds' do
      expect { raise ArgumentError, 'Success' }.to raise_error(ArgumentError)
    end
  end
end
