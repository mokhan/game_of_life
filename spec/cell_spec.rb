describe Cell do
  let(:populated_neighbor) { Cell.new(populated: true) }
  let(:unpopulated_neighbor) { Cell.new(populated: false) }
  let(:world) { double }

  context "when populated" do
    subject { Cell.new(populated: true) }

    it "is populated at creation" do
      expect(subject.populated?).to be_truthy
    end

    context "when it has a single populated neighbor" do
      let(:neighbors) { [populated_neighbor, unpopulated_neighbor] }

      it "dies of isolation" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_populated
      end
    end

    context 'when it has two populated neighbors' do
      let(:neighbors) { [populated_neighbor] * 2 }

      it "remains populated" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to be_populated
      end
    end

    context 'when it has three populated neighbors' do
      let(:neighbors) { [populated_neighbor] * 3 }

      it "remains populated" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to be_populated
      end
    end

    context 'when it has more than three neighbors' do
      let(:neighbors) { [populated_neighbor] * 4 }

      it "becomes unpopulated" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_populated
      end
    end
  end

  context "when unpopulated" do
    subject { Cell.new(populated: false) }
    let(:populated_neighbors) { [populated_neighbor] * 2 }
    let(:neighbors) { populated_neighbors + [unpopulated_neighbor] }

    context "when it has two populated neighbors" do
      it "remains unpopulated" do
        world.stub(:neighbors_for).with(subject).and_return(neighbors)
        expect(subject.spawn(world)).to_not be_populated
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
      Cell.new.tap do |cell|
        cell.x = x
        cell.y = y
      end
    end
  end
end

