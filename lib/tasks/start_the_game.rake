# frozen_string_literal: true

require_relative '../../app/game'

desc 'Start the Game'
task game: :environment do
  Game.new('test/fixtures/input.txt', 'test/fixtures/output.txt').start
end
