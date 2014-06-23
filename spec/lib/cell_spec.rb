describe Cell do
  let(:living_neighbor) { Cell.new(alive: true) }
  let(:dead_neighbor) { Cell.new(alive: false) }
  let(:world) { double }

  context "when alive" do
    subject { Cell.new(alive: true) }

    it "is alive at creation" do
      expect(subject.alive?).to be_truthy
    end

    context "when it has a single living neighbor" do
      let(:neighbors) { [living_neighbor, dead_neighbor] }

      it "dies of isolation" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_alive
      end
    end

    context 'when it has two living neighbors' do
      let(:neighbors) { [living_neighbor] * 2 }

      it "remains living" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to be_alive
      end
    end

    context 'when it has three living neighbors' do
      let(:neighbors) { [living_neighbor] * 3 }

      it "remains living" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to be_alive
      end
    end

    context 'when it has more than three neighbors' do
      let(:neighbors) { [living_neighbor] * 4 }

      it "dies" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_alive
      end
    end
  end

  context "when dead" do
    subject { Cell.new(alive: false) }
    let(:living_neighbors) { [living_neighbor] * 2 }
    let(:neighbors) { living_neighbors + [dead_neighbor] }

    context "when it has two living neighbors" do
      it "remains dead" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_alive
      end
    end
  end

  describe "neighbor?" do
    subject { create_cell(3, 3) }

    context "when other cell is one cell north" do
      it "returns true" do
        expect(subject.neighbor?(create_cell(3, 4))).to be_truthy
      end
    end

    context "when the other cell is two cells north" do
      it "returns false" do
        expect(subject.neighbor?(create_cell(3, 5))).to be_falsey
      end
    end

    context "when other cell is one cell east" do
      it "returns true" do
        expect(subject.neighbor?(create_cell(4, 3))).to be_truthy
      end
    end

    context "when other cell is two cells to the east" do
      it "returns true" do
        expect(subject.neighbor?(create_cell(5, 3))).to be_falsey
      end
    end

    context "when the other cell is one cell to the south" do
      it "return true" do
        expect(subject.neighbor?(create_cell(3, 2))).to be_truthy
      end
    end

    context "when the other cell is two cells to the south" do
      it "returns false" do
        expect(subject.neighbor?(create_cell(3, 1))).to be_falsey
      end
    end

    context "when the other cell is one cell to the west" do
      it "returns true" do
        expect(subject.neighbor?(create_cell(2, 3))).to be_truthy
      end
    end

    context "when the other cell is two cells to the west" do
      it "returns true" do
        expect(subject.neighbor?(create_cell(1, 3))).to be_falsey
      end
    end

    def create_cell(x, y)
      Cell.new(x: x, y: y)
    end
  end
end

