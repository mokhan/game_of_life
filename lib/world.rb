class World
  def initialize(cells)
    @cells = cells
  end

  def neighbors_for(cell)
    @cells.find_all { |x| cell.neighbor?(x) }
  end

  def begin
    @cells.each do |cell|
      cell.spawn(self)
    end
  end
end
