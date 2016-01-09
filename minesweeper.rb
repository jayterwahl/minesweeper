class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(9){ Array.new(9) {Tile.new} }
    assign_bombs
    populate_tiles
    self.render
  end

  def populate_tiles
    grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|

        tile.set_grid(self)
        tile.set_pos(i, j)
        tile.assign_value
      end
    end
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        # p el.value if el.revealed
        print " #{tile.reveal} "
      end
      puts
    end
  end

  def assign_bombs
    #this doesn't assign the right number of bombs; use shuffle?
    num_of_bombs = 10
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
  attr_reader :revealed, :grid, :value

  def initialize()
    @grid = nil
    @revealed = true
    @is_bomb = false
    @value = 0
  end

  def set_grid(board)
    @grid = board.grid
  end

  def set_pos(i, j)
    @pos = [i,j]
  end

    #iterate over every tile; they know if they're bombs
    #use a neighbor_bomb_count method to assign one's own number
    #assign all of this before any rendering happens



  def reveal
    return "💀" if @is_bomb
    return "*" unless @revealed
    return "_" if @value == 0
    @value
  end



  def neighbors(row, col)
    neighbors = []
    #i'm so sorry everyone
    neighbors << [row - 1, col - 1] unless row == 0 || col == 0
    neighbors << [row, col - 1] unless col == 0
    neighbors << [row + 1, col - 1] unless row == 8 || col == 0
    neighbors << [row - 1, col] unless row == 0
    neighbors << [row + 1, col] unless row == 8
    neighbors << [row - 1, col + 1] unless row == 0 || col == 8
    neighbors << [row, col + 1] unless col == 8
    neighbors << [row + 1, col + 1] unless row == 8 || col == 8
    #we could do this with while loops
    #so, so sorry
    neighbors
    #this is an array of neighbors
  end

  def neighbor_bomb_count(neighbor_array)
    bomb_count = 0
    neighbor_array.each do |neighbor|

      # next if @grid[neighbor[0]][neighbor[1]].nil?
      if grid[neighbor[0]][neighbor[1]].is_bomb
        bomb_count += 1
      end
    end
    bomb_count

  end

  def assign_value
    # @grid.each_with_index do |row, i|
    #   row.each_with_index do |tile, j|
    neighbor_array = neighbors(*@pos)
    @value = neighbor_bomb_count(neighbor_array)
    #   end
    # end
  end

end

# #reveal, #neighbors, #neighbor_bomb_count


class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end


  def play
    until game_over?
      get_player_input
    end
  end


  def get_player_input
    puts "Player!"
    puts "Please input the coordinates you'd like to explore."
    puts "If you want to flag a position, preface with \"f\"."
    puts "If you want to explore a condition, preface with \"e\"."
    puts "In format: letter row column."
    puts "E.g: f 0 1"
    puts ">> "
    input = STDIN.gets.chomp
    clean_up_user_input(input)
  end


  def clean_up_user_input(input)
    @letter = input.slice!(0)
    input = input.split
    @selected_tile = board.grid[input[0]][input[1]]
  end


  def game_over?
    puts "YOU WIN!"
    game_won? || bomb_detonated?
  end


  def game_won?
    board.grid.each do |row|
      row.all? do |tile|
        next if tile.is_bomb
        tile.revealed
      end
    end
  end


  def bomb_detonated?
    @selected_tile.is_bomb
  end
end


if __FILE__ == $0
  game = Game.new
  game.play
end
