class Game
  def initialize(printer)
    @printer = printer
  end

  def play(max_x, max_y)
    world = World.new(create_cells(max_x, max_y))
    until world.empty? do
      @printer.print(world)
      world.next_generation!
    end
  end

  def create_cells(max_x, max_y)
    items = []
    (1..max_x).each do |x|
      (1..max_y).each do |y|
        items.push(Cell.new(x: x, y: y, populated: random_population))
      end
    end
    items
  end

  private

  def random_population
    rand(100).even?
  end
end
