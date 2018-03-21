#Returns the shortest path from one vertex to another in a graph of 64 vertices emulating a chess table
#only using the Chess Knight's movements to traverse it.
class Knight

  def initialize
    @x = nil
    @y = nil  
  end

  def out_of_bounds?(move)
  	x = move[0]
  	y = move[1]
  	return true if x < 0 || x > 7 || y < 0 || y > 7
    false
  end

  def update_possible_moves(start)
    @x = start[0]
    @y = start[1]
    @moves = [[@x + 2, @y + 1], [@x + 1, @y + 2], [@x - 1, @y + 2], 
              [@x - 2, @y + 1], [@x - 2, @y - 1], [@x - 1, @y - 2],
              [@x + 1, @y - 2], [@x + 2, @y - 1]]
  end
  # All the vertices of the knight's start and the children
  # needed to reach the target vertex will be in "path" along with the backtracking
  def best_path(start, target)
    queue = []
    path = []
    targetX = target[0]
    targetY = target[1]  
    update_possible_moves(start)
    path << [@x, @y]
    until @x == targetX && @y == targetY
      @moves.each do |valid_move|
        queue << valid_move unless out_of_bounds?(valid_move) 
      end
      #shift because we want bread-first search
      next_move = queue.shift
      update_possible_moves(next_move)
      path << [@x, @y]  
    end
    # Filter out the best path and present it
    best_possible_path = filter_path(path)
    puts "You made it in #{best_possible_path.length} moves! The path is:\n#{best_possible_path}"
  end

  # Filter out the best path
  def filter_path(path)
    best_possible_path = [path[-1]]
    current_target = path.pop
    update_possible_moves(current_target)
    while path.length > 0
      candidate = path.pop
      if @moves.include?(candidate) 
        best_possible_path << candidate
        current_target = candidate
        update_possible_moves(current_target)
      end
    end
    best_possible_path.reverse
  end

end

horsey_revenge = Knight.new
horsey_revenge.best_path([7,7], [0,1])