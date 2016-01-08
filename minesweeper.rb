class Board
  def initialize
    @grid = Array.new(9){ Array.new(9) {Tile.new} }
    assign_bombs
    self.render
  end

  def assign_values()



    #iterate over every tile; they know if they're bombs
    #use a neighbor_bomb_count method to assign one's own number
    #assign all of this before any rendering happens

  end


  def render
    @grid.each_with_index do |row, index|
      row.each_with_index do |el, j|
        # p el.value if el.revealed
        print "#{el.is_bomb} "
      end
      puts
    end
  end

  def assign_bombs
    #this doesn't assign the right number of bombs; use shuffle?
    num_of_bombs = 5
    num_of_bombs.times do
      @grid[rand(9)][rand(9)].is_bomb = true
    end


  end
end

#
# grid.each_with_index do |row, i|
#   row.each_with_index do |card, j|
#     if card.face_up == true
#       render_grid[i][j] = grid[i][j].value
#     end
#   end
#   print render_grid[i]
#   puts
# end



class Tile

  attr_accessor :is_bomb
  attr_reader :revealed

  def initialize
    @revealed = true
    @is_bomb = false
    @value = 0
  end

  def reveal
    return "💀" if @is_bomb
    return "*" unless @revealed
    return "_" if @value == 0
    @value
  end


  def neighbors(row, col)
    neighbors = []
    #i'm so sorry everyone
    neighbors << [row - 1, col - 1]
    neighbors << [row, col - 1]
    neighbors << [row + 1, col - 1]
    neighbors << [row - 1, col]
    neighbors << [row + 1, col]
    neighbors << [row - 1, col + 1]
    neighbors << [row, col + 1]
    neighbors << [row + 1, col + 1]
    #we could do this with while loops
    neighbors

  end


  def neighbor_bomb_count(neighbor_array)
    bomb_count = 0
    neighbor_array.each do |neighbor|
      bomb_count += 1 if @grid[neighbor_array[0]][neighbor_array[1]].is_bomb
    end
    @value = bomb_count
  end
end

# #reveal, #neighbors, #neighbor_bomb_count


class Game
  def play


  end
end
