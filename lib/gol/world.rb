class World
  include Enumerable

  def initialize(cells)
    @cells = cells
  end

  def neighbors_for(cell)
    @cells.find_all { |x| cell.neighbor?(x) }
  end

  def next_generation!
    @cells = map { |cell| cell.spawn(self) }
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end

  def empty?
    !any? { |x| x.populated? }
  end
end
