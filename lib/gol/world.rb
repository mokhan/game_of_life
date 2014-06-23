class World
  include Enumerable

  def initialize(cells)
    @cells = cells
  end

  def neighbors_for(cell)
    @cells.find_all { |x| cell.neighbor?(x) }
  end

  def begin
    each do |cell|
      cell.spawn(self)
    end
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end
end
