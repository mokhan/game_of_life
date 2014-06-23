class Game
  def initialize(printer)
    @printer = printer
  end

  def play(max_x, max_y)
    world = World.new(create_cells(max_x, max_y))
    10.times do
      world.begin
      print(world)
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

  def print(world)
    world.each_with_index do |cell, index|
      @printer.print("|#{cell.print}|")
      @printer.puts if index % 3 == 0
    end
  end

  def random_population
    rand(10).even?
  end
end
