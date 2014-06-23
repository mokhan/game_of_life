class Printer
  def initialize(max_x)
    @max_x = max_x
  end

  def print(world)
    world.each_with_index do |cell, index|
      print cell.populated? ? "X" : " "
      puts if (index+1) % @max_x == 0
    end
  end
end
