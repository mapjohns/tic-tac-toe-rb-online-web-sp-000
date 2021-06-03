WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8],[6,4,2]]

# Helper Methods
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(board, index, current_player)
    board[index] = current_player
  end
  
  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  # Define your play method below
  def turn_count(board)
    t_count = 0
    board.each do |board_item|
        if board_item != " "
            t_count += 1
        end
    end
    puts "It is turn #{t_count}"
    return t_count
end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end 
end


def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    val = valid_move?(board, index)
    if val == false
        puts "Please try another number"
        turn(board)
    else
        move(board,index,current_player(board))
        display_board(board)
    end
end

def won?(board)
    end_result = []
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
     
      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3
     
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        end_result.append("win!")
        return win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        end_result.append("win!")
        return win_combination
      end
    end
    if end_result[0] != "win!"
      return false
    end 
  end
  
  def full?(board)
    if board.include?(" ") == true
      return false
    else 
      return true
    end
  end
  
  def draw?(draw_board)
    if won?(draw_board) == false && full?(draw_board) == true #Board not won, but full
        return true
    else 
        return false
    end
  end 
  
  def over?(board)
    if draw?(board) == true || won?(board) != false || full?(board) == true
      return true
    else
      return false
    end
  end 
  
  def winner(board)
    win_comb = []
    win_comb = won?(board)
    if win_comb == false
      return nil
    elsif board[win_comb[0]] == 'X'
      return 'X'
    elsif board[win_comb[0]] == 'O'
      return 'O'
    end
  end 

  def play(board)
    until over?(board) == true
        turn(board)
    end
    if winner(board) == 'X'
        puts "Congratulations X!"
    elsif winner(board) == 'O'
        puts "Congratulations O!"
    else
        puts "Cat's Game!"
    end
end
