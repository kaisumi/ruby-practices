#!/usr/bin/env ruby
# frozen_string_literal: true

COLS = 4
MIN_LENGTH = 16

def files
  Dir.entries('.').sort
end

def length(files)
  max_length = files.map(&:length).max
  max_length > MIN_LENGTH ? max_length : MIN_LENGTH
end

def array_of_columns(files, length)
  rows = files.instance_of?(Array) ? (files.length.to_f / COLS).ceil : 1
  Array.new(COLS).map.with_index do |_col, col_i|
    Array.new(rows).map.with_index do |_row, row_i|
      file = files[rows * col_i + row_i]
      (file.nil? ? '' : file).ljust(length)
    end
  end
end

length = length(files)

array_of_columns = array_of_columns(files, length)

print_string = array_of_columns.transpose.map(&:join).join("\n")

print print_string
