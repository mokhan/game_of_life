class Printer
  def initialize(max_x)
    @max_x = max_x
  end

  def display(world)
    world.each_with_index do |cell, index|
      print cell.alive? ? "X" : " "
      puts if (index+1) % @max_x == 0
    end
  end
end
