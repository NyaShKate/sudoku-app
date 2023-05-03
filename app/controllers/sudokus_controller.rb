class SudokusController < ApplicationController

  def index
    @sudoku = [[0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0]]
    if params.has_key? :sudoku
      (0..8).each do |i|
        (0..8).each do |j|
          @sudoku[i][j] = params[:sudoku][i*9+j]
        end
      end
    end
  end

  def enter
    sudoku = [[0,0,0,0,0,0,0,0,0],
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
        sudoku[i][j] = params[str.parameterize.underscore.to_sym].to_i
      end
    end
    puts sudoku.to_s

    redirect_to action: 'index', :notice => check(sudoku), :sudoku => sudoku
  end

  def generate
    sudoku = [[0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0]]

    puts  gen(sudoku,rand(10..64))
    redirect_to action: 'index', :sudoku => gen(sudoku,rand(10..64))
  end

  def solver
    sudoku = [[0,0,0,0,0,0,0,0,0],
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
        sudoku[i][j] = params[str.parameterize.underscore.to_sym].to_i
      end
    end

    redirect_to action: 'index', :sudoku => solve(sudoku)
  end


  def solve(sudoku)
    empties = find_empties(sudoku)
    return sudoku if !empties
      (1..9).to_a.shuffle.each do |num|
        sudoku[empties[:i]][empties[:j]] = num
        if condition(sudoku, empties[:i],empties[:j], num)
          return sudoku if solve(sudoku) # Recursively call solve method again.
          sudoku[empties[:i]][empties[:j]] = 0
        else
          sudoku[empties[:i]][empties[:j]] = 0
        end
      end
    return false
  end

  def condition(sudoku,i,j,num)
    one_in_row?(sudoku,i,num) && one_in_col?(sudoku,j,num) && one_in_box?(sudoku,i,j,num)
  end

  def find_empties(sudoku)
    empty = {i:0,j:0}
     sudoku.each do |row|
        emp_next = row.find_index(0)
        empty[:i] = sudoku.find_index(row) # row
        empty[:j] = emp_next  #  col
      return empty if empty[:j]
    end
    return false
  end

  def gen(sudoku,boxes)
    sudoku = solve(sudoku)
    (1..boxes).each do |i|
      if sudoku[rand(0..8)][rand(0..8)] != 0
        sudoku[rand(0..8)][rand(0..8)] = 0
      end
    end
    sudoku
  end

  def check(sudoku)
    return 'Invalid pattern for checking it out!' if sudoku.count(0) != 0
    (0..8).each do |i|
      (0..8).each do |j|
        return 'I\'m sorry, but it is wrong...Probably something go wrong in solution...' if !(one_in_row?(sudoku,i,sudoku[i][j]) &&
            one_in_col?(sudoku,j,sudoku[i][j]) &&
            one_in_box?(sudoku,i,j,sudoku[i][j]))
        end
    end
    return 'It is indeed correct solution! Congrats!'
  end

  def one_in_row?(sudoku,i,num)
    (sudoku[i].count(num) == 1)
  end

  def one_in_col?(sudoku,j,num)
    count = 1
    sudoku.each do |r|
      if r[j] == num
        count-=1
      end
      if count < 0
        return false
      end
    end
    return true
  end

  def one_in_box?(sudoku,i,j,num)
    bsr = (i - (i % 3))
    bsc = (j - (j % 3))

    count = 1
    (0..2).to_a.each do |box_row|
      (0..2).to_a.each do |box_col|
        if sudoku[bsr + box_row][bsc + box_col] == num
          count-=1
        end
        if count < 0
          return false
        end
      end
    end
    return true
  end


end
