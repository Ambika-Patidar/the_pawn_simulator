# frozen_string_literal: true

class FileAccessor
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def parse
    parsed_data = []
    File.foreach(@file) { |line| parsed_data << line.chomp }
    parsed_data
  end

  def write_into_file(data)
    File.write(file, data)
  end
end
