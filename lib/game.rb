class Game
  def initialize(printer)
  end

  def play(max_x, max_y)
    World.new
  end

  def create_cells(max_x, max_y)
    items = []
    (1..max_x).each do |x|
      (1..max_y).each do |y|
        items.push(Cell.new(x: x, y: y))
      end
    end
    items
  end
end
