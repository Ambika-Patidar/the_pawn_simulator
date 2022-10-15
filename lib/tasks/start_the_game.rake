require_relative '../../app/game'

desc 'Start the Game'
task game: :environment do
  game = Game.new('test/fixtures/input.txt', 'test/fixtures/output.txt')
  result = game.start
end
