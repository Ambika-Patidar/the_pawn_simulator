# frozen_string_literal: true

require_relative 'cell'

class Board
  attr_accessor :board, :dimensions

  def initialize
    @board = {}
    @dimensions = 8
  end

  def construct
    (0...dimensions).each do |i|
      (0...dimensions).each do |j|
        key = [i, j].join(',')
        current_cell = Cell.new
        current_cell.value = {}
        @board[key] = current_cell
      end
    end
  end
end
