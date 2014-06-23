describe Game do
  subject { Game.new(printer) }
  let(:printer) { double }

  context "#create_cells" do
    context "for a 2x2 grid" do
      let(:results) { subject.create_cells(2, 2) }

      it "returns the correct number of cells" do
        expect(results.count).to eql(4)
      end

      it "returns a cell for each coordinate" do
        expect(find(1, 1).x).to eql(1)
        expect(find(1, 1).y).to eql(1)
        expect(find(1, 2).x).to eql(1)
        expect(find(1, 2).y).to eql(2)
        expect(find(2, 1).x).to eql(2)
        expect(find(2, 1).y).to eql(1)
        expect(find(2, 2).x).to eql(2)
        expect(find(2, 2).y).to eql(2)
      end

      def find(x, y)
        results.find { |cell| cell.x == x && cell.y == y }
      end
    end
  end
end
