# frozen_string_literal: true

require_relative 'file_accessor'
require_relative 'pawn'

class Game
  COMMANDS = {
    PLACE: 'PLACE', MOVE: 'MOVE', LEFT: 'LEFT', RIGHT: 'RIGHT', REPORT: 'REPORT'
  }.freeze

  def initialize(input_file, output_file)
    @input_file = FileAccessor.new(input_file)
    @output_file = FileAccessor.new(output_file)
  end

  def start
    input = @input_file.parse
    first_command = input[0].split(' ')
    return puts 'Please use correct input' if first_command[0] != 'PLACE'

    @output_file.write_into_file('')

    execute(input)
  end

  def execute(input)
    board = Board.new
    board.construct

    pawn = Pawn.new(board)
    input.each do |row|
      data = row.split(' ')
      case data[0]
      when COMMANDS[:PLACE] then pawn.place_the_pawn(data[1])
      when COMMANDS[:MOVE] then pawn.move_the_pawn(data[1])
      when COMMANDS[:LEFT] then pawn.left_the_pawn
      when COMMANDS[:RIGHT] then pawn.right_the_pawn
      when COMMANDS[:REPORT]
        current_origin = board.board[[pawn.x, pawn.y].join(',')]
        @output_file.write_into_file([pawn.x, pawn.y, current_origin[:facing], current_origin[:colour]].join(','))
      end
    end
  end
end
