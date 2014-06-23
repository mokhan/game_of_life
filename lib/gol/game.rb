class Game
  def initialize(printer)
    @printer = printer
  end

  def play(max_x, max_y)
    World.new(create_cells(max_x, max_y)).tap do |world|
      until world.empty? do
        @printer.display(world)
        world.next_generation!
      end
    end
  end

  def create_cells(max_x, max_y)
    items = []
    (1..max_x).each do |x|
      (1..max_y).each do |y|
        items.push(Cell.new(x: x, y: y, alive: random_life))
      end
    end
    items
  end

  private

  def random_life
    rand(100).even?
  end
end
