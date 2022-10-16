# frozen_string_literal: true

require_relative 'file_accessor'
require_relative 'pawn'

class Game
  def initialize(input_file, output_file)
    @input_file = FileAccessor.new(input_file)
    @output_file = FileAccessor.new(output_file)
  end

  def start
    input = @input_file.parse
    first_command = input[0].split(' ')
    return puts 'Please use correct input' if first_command[0] != 'PLACE'

    File.write(@output_file.file, '')

    pawn = Pawn.new

    input.each do |row|
      data = row.split(' ')
      case data[0]
      when 'PLACE'
        pawn.place_the_pawn(data[1])
      when 'MOVE'
        pawn.move_the_pawn(data[1])
      when 'LEFT'
        pawn.left_the_pawn
      when 'RIGHT'
        pawn.right_the_pawn
      when 'REPORT'
        current_origin = pawn.board.board[[pawn.x, pawn.y].join(',')]
        output = pawn.x, pawn.y, current_origin[:facing], current_origin[:colour]
        File.write(@output_file.file, output.join(','))
      end
    end
  end
end
