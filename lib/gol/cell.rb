class Cell
  attr_reader :x, :y

  def initialize(alive: false, x: 1, y: 1)
    @alive = alive
    @x, @y = x, y
  end

  def spawn(world)
    living_neighbors = world.neighbors_for(self).find_all { |x| x.alive? }
    if alive?
      Cell.new(alive: (2...4).include?(living_neighbors.count), x: x, y: y)
    else
      Cell.new(alive: living_neighbors.count == 3, x: x, y: y)
    end
  end

  def neighbor?(other_cell)
    return true if x?(other_cell) && one_cell_away(other_cell.y - self.y)
    return true if y?(other_cell) && one_cell_away(other_cell.x - self.x)
    false
  end

  def alive?
    @alive
  end

  private

  def x?(other_cell)
    other_cell.x == x
  end

  def y?(other_cell)
    other_cell.y == y
  end

  def one_cell_away(difference)
    difference.abs == 1
  end
end
