class Game
  def initialize(printer)
    @printer = printer
  end

  def play(max_x, max_y)
    world = World.new(create_cells(max_x, max_y))
    until world.empty? do
      print(world, max_x)
      world.next_generation
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

  def print(world, max_x)
    world.each_with_index do |cell, index|
      @printer.print("#{cell.print}")
      @printer.puts if (index+1) % max_x == 0
    end
  end

  def random_population
    rand(100).even?
  end
end
