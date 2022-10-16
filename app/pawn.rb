# frozen_string_literal: true

require_relative 'board'

class Pawn
  attr_accessor :x, :y, :board

  def initialize
    @board = Board.new
    @board.construct
    @x = 0
    @y = 0
  end

  def place_the_pawn(data)
    place_data = data.split(',')
    @x = place_data[0].to_i
    @y = place_data[1].to_i
    board.board[[x, y].join(',')] = { facing: place_data[2], colour: place_data[-1] }
  end

  def move_the_pawn(data)
    from = board.board[[x, y].join(',')]
    case from[:facing]
    when 'NORTH' then @y = data.present? ? @y + data.to_i : @y + 1
    when 'EAST' then @x = data.present? ? @x + data.to_i : @y + 1
    when 'WEST' then @x = data.present? && @y.positive? ? data.to_i - @x : @y - 1
    when 'SOUTH' then @y = data.present? && @y.positive? ? data.to_i - @y : @y - 1
    end
    board.board[[@x, @y].join(',')] = {
      facing: from[:facing], colour: from[:colour]
    }
  end

  def left_the_pawn
    current_origin = board.board[[@x, @y].join(',')]
    current_origin[:facing] = case current_origin[:facing]
                              when 'NORTH' then 'WEST'
                              when 'SOUTH' then 'EAST'
                              when 'EAST' then 'NORTH'
                              when 'WEST' then 'SOUTH'
                              end
  end

  def right_the_pawn
    current_origin = board.board[[@x, @y].join(',')]
    current_origin[:facing] = case current_origin[:facing]
                              when 'NORTH' then 'EAST'
                              when 'SOUTH' then 'WEST'
                              when 'EAST' then 'SOUTH'
                              when 'WEST' then 'NORTH'
                              end
  end
end
