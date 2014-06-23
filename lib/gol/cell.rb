class Cell
  attr_reader :x, :y

  def initialize(populated: false, x: 1, y: 1)
    @populated = populated
    @x, @y = x, y
  end

  def spawn(world)
    populated_neighbors = world.neighbors_for(self).find_all { |x| x.populated? }
    if populated?
      Cell.new(populated: (2...4).include?(populated_neighbors.count), x: x, y: y)
    else
      Cell.new(populated: populated_neighbors.count == 3, x: x, y: y)
    end
  end

  def neighbor?(other_cell)
    return true if matches_x?(other_cell) && one_cell_away(other_cell.y - self.y)
    return true if matches_y?(other_cell) && one_cell_away(other_cell.x - self.x)
    false
  end

  def populated?
    @populated
  end

  private

  def matches_x?(other_cell)
    other_cell.x == x
  end

  def matches_y?(other_cell)
    other_cell.y == y
  end

  def one_cell_away(difference)
    difference.abs == 1
  end
end
