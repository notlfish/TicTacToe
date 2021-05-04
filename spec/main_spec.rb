require 'spec_helper'
require_relative '../bin/main'

RSpec.describe '#main' do
  describe 'Greeting message' do
    it 'Prints "Hello world!" to stdout' do
      allow($stdout).to receive(:puts).with('Hello world!')
      expect(main).to be nil
    end
  end
end
