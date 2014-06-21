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

describe World do
  subject { World.new(cells) }
  let(:cells) { [neighbor, other_cell] }
  let(:neighbor) { Object.new }
  let(:other_cell) { Object.new }

  context "#neighbors_for" do
    let(:cell) { Object.new }

    before :each do
      cell.stub(:neighbor?).with(neighbor).and_return(true)
      cell.stub(:neighbor?).with(other_cell).and_return(false)
    end

    it "returns the neighboring cells" do
      expect(subject.neighbors_for(cell)).to include(neighbor)
    end

    it "does not return cells that are not neighbors" do
      expect(subject.neighbors_for(cell)).to_not include(other_cell)
    end
  end

  context "begin" do
    subject { World.new([cell]) }
    let(:cell) { double(spawn: true) }

    it "visits each cell" do
      subject.begin
      expect(cell).to have_received(:spawn).with(subject)
    end
  end
end
