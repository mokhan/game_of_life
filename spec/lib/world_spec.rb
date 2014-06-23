describe World do
  subject { World.new(cells) }
  let(:cells) { [neighbor, other_cell] }
  let(:neighbor) { double }
  let(:other_cell) { double }

  context "#neighbors_for" do
    let(:cell) { Cell.new }

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

  context "#next_generation!" do
    subject { World.new([cell]) }
    let(:cell) { double(spawn: true) }

    it "visits each cell" do
      subject.next_generation!
      expect(cell).to have_received(:spawn).with(subject)
    end
  end

  context "#empty?" do
    context "when there are no living cells" do
      it "returns true" do
        neighbor.stub(:alive?).and_return(false)
        other_cell.stub(:alive?).and_return(false)
        expect(subject).to be_empty
      end
    end

    context "when there is at least one living cell" do
      it "returns false" do
        neighbor.stub(:alive?).and_return(false)
        other_cell.stub(:alive?).and_return(true)
        expect(subject).to_not be_empty
      end
    end
  end
end
