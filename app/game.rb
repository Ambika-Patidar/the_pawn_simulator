require_relative 'file_accessor'
require_relative 'board'

class Game
  def initialize(input_file, output_file)
    @input_file = FileAccessor.new(input_file)
    @output_file = FileAccessor.new(output_file)
  end

  def start
    input = @input_file.parse
    first_command = input[0].split(' ')
    return puts 'Please use correct input' if first_command[0] != 'PLACE'

    board = Board.new
    board.construct

    File.write(@output_file.file, '')

    origin = [0, 0]
    input.each do |row|
      data = row.split(' ')
      case data[0]
      when 'PLACE'
        place_data = data[1].split(',')
        origin = [place_data[0], place_data[1]]
        board.board[origin.join(',')] = { facing: place_data[2], colour: place_data[-1] }
      when 'MOVE'
        from = board.board[origin.join(',')]

        case from[:facing]
        when 'NORTH'
          origin[1] = data[1].present? ? origin[1].to_i + data[1].to_i : origin[1].to_i + 1
        when 'EAST'
          origin[0] = data[1].present? ? origin[0].to_i + data[1].to_i : origin[1].to_i + 1
        when 'WEST'
          origin[0] = data[1].present? && origin[1].to_i.positive? ? data[1].to_i - origin[0].to_i : origin[1].to_i - 1
        when 'SOUTH'
          origin[1] = data[1].present? && origin[1].to_i.positive? ? data[1].to_i - origin[1].to_i : origin[1].to_i - 1
        end

        board.board[origin.join(',')] = { facing: from[:facing], colour: from[:colour] }
      when 'LEFT'
        current_origin = board.board[origin.join(',')]
        current_origin[:facing] = case current_origin[:facing]
                                  when 'NORTH'
                                    'WEST'
                                  when 'SOUTH'
                                    'EAST'
                                  when 'EAST'
                                    'NORTH'
                                  when 'WEST'
                                    'SOUTH'
                                  end
      when 'RIGHT'
        current_origin = board.board[origin.join(',')]
        current_origin[:facing] = case current_origin[:facing]
                                  when 'NORTH'
                                    'EAST'
                                  when 'SOUTH'
                                    'WEST'
                                  when 'EAST'
                                    'SOUTH'
                                  when 'WEST'
                                    'NORTH'
                                  end
      when 'REPORT'
        current_origin = board.board[origin.join(',')]
        output = origin[0], origin[-1], current_origin[:facing], current_origin[:colour]
        File.write(@output_file.file, output.join(','))
      end
    end
  end
end
