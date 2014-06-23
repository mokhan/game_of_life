class Printer
  def initialize(max_x)
    @max_x = max_x
  end

  def display(world)
    clear
    world.each_with_index do |cell, index|
      print cell.alive? ? "X" : " "
      puts if (index+1) % @max_x == 0
    end
    sleep 1
  end

  private

  def clear
    puts "\e[H\e[2J"
  end
end
