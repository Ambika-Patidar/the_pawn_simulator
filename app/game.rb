require_relative 'file_accessor'
require_relative 'board'

class Game
  def initialize(input_file, output_file)
    @input_file = FileAccessor.new(input_file)
    @output_file = FileAccessor.new(output_file)
  end

  def start
    input = @input_file.parse
    first_input = input[0].split(' ')
    return puts 'Please use correct input' if first_input[0] != 'PLACE'

    board = Board.new
    board.construct
    File.write(@output_file.file, '')
    origin = [0, 0]
    input.each do |data|
      splited_data = data.split(' ')
      case splited_data[0]
      when 'PLACE'
        place_data = splited_data[1].split(',')
        origin = key = [place_data[0], place_data[1]]
        board.board[key.join(',')] = { facing: place_data[2], colour: place_data[-1] }
      when 'MOVE'
        from = board.board[origin.join(',')]
        if from[:facing] == 'NORTH'
          origin[1] = splited_data[1].present? ? origin[1].to_i + splited_data[1].to_i : origin[1].to_i + 1
        elsif from[:facing] == 'EAST'
          origin[0] = splited_data[1].present? ? origin[0].to_i + splited_data[1].to_i : origin[1].to_i + 1
        elsif from[:facing] == 'WEST'
          origin[0] = splited_data[1].present? ? splited_data[1].to_i - origin[0].to_i : origin[1].to_i - 1 if origin[1].to_i > 0
        elsif from[:facing] == 'SOUTH'
          origin[1] = splited_data[1].present? ? splited_data[1].to_i - origin[1].to_i : origin[1].to_i - 1 if origin[1].to_i > 0 
        end
        board.board[origin.join(',')] = { facing: from[:facing], colour: from[:colour] }
      when 'LEFT'
        current_origin = board.board[origin.join(',')]
        current_origin[:facing] = if current_origin[:facing] == 'NORTH'
                                    'WEST'
                                  elsif current_origin[:facing] == 'SOUTH'
                                    'EAST'
                                  elsif current_origin[:facing] == 'EAST'
                                    'NORTH'
                                  elsif current_origin[:facing] == 'WEST'
                                    'SOUTH'
                                  end
      when 'RIGHT'
        current_origin = board.board[origin.join(',')]
        current_origin[:facing] = if current_origin[:facing] == 'NORTH'
                                    'EAST'
                                  elsif current_origin[:facing] == 'SOUTH'
                                    'WEST'
                                  elsif current_origin[:facing] == 'EAST'
                                    'SOUTH'
                                  elsif current_origin[:facing] == 'WEST'
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
