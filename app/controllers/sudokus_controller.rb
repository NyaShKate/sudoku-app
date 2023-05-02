class SudokusController < ApplicationController
  def index
    # puts params
    @sudoku = [[0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0]]

    (0..8).each do |i|
      (0..8).each do |j|
        str = 'e'+(i*10+j).to_s
        puts params[str.parameterize.underscore.to_sym]
        @sudoku[i][j] = params[str.parameterize.underscore.to_sym]
      end
    end

    if params.has_key? :check
    #  check function
    end

    if params.has_key? :gen
      #  auto-gen function
    end

    if params.has_key? :solve
      #  solve function
    end

    # puts @sudoku.to_s
  end
end
