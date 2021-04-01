require "position"

describe Position do

  describe "initial position" do
    context "at the beginning of the game" do
      it "kazans are empty" do
        expect(Position.new.kazan1).to eq(0)
        expect(Position.new.kazan2).to eq(0)
      end

      it "otaus have nine kumalaks" do
        expect(Position.new.player1).to eq([9, 9, 9, 9, 9, 9, 9, 9, 9])
        expect(Position.new.player2).to eq([9, 9, 9, 9, 9, 9, 9, 9, 9])
      end
    end
  end

  describe "step" do
    context "if step is baily" do
      it "all kumalaks go to kazan" do
        position = Position.new

        position = position.step(1, 4)

        expect(position.kazan1).to eq(10)
        expect(position.player1).to eq([9, 9, 9, 9, 1, 10, 10, 10, 10])
        expect(position.player2).to eq([10, 10, 10, 0, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(0)
      end

      it "all kumalaks go to kazan (corner case: ends at 1st otau)" do
        position = Position.new(
          [9, 9, 9, 9, 1, 10, 10, 10, 10], 10,
          [10, 10, 10, 0, 9, 9, 9, 9, 9], 0)

        position = position.step(2, 0)

        expect(position.kazan1).to eq(10)
        expect(position.player1).to eq([0, 9, 9, 9, 1, 10, 10, 10, 10])
        expect(position.player2).to eq([1, 11, 11, 1, 10, 10, 10, 10, 10])
        expect(position.kazan2).to eq(10)
      end
    end
  end

  describe "tuzdyk" do
    context "kumalak fall to tuzdyk" do
      it "goes to opponent kazan if on my half" do
        position = Position.new(
          [8, 9, 9, 9, 'x', 10, 10, 10, 0], 10,
          [10, 10, 10, 0, 9, 9, 9, 9, 9], 12)

        position = position.step(1, 0)

        expect(position.kazan1).to eq(10)
        expect(position.player1).to eq([1, 10, 10, 10, 'x', 11, 11, 11, 0])
        expect(position.player2).to eq([10, 10, 10, 0, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(13)
      end

      it "goes to opponent kazan (one step corner case)" do
        position = Position.new(
          [16, 9, 9, 1, 'x', 10, 10, 10, 0], 10,
          [10, 10, 10, 0, 9, 9, 9, 9, 9], 12)

        position = position.step(1, 3)

        expect(position.kazan1).to eq(10)
        expect(position.player1).to eq([16, 9, 9, 0, 'x', 10, 10, 10, 0])
        expect(position.player2).to eq([10, 10, 10, 0, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(13)
      end

      it "goes to my kazan if on opponent half" do
        position = Position.new(
          [8, 9, 9, 9, 9, 10, 10, 10, 0], 11,
          [10, 'x', 10, 0, 9, 9, 9, 9, 9], 12)

        position = position.step(1, 4)

        expect(position.kazan1).to eq(12)
        expect(position.player1).to eq([8, 9, 9, 9, 1, 11, 11, 11, 1])
        expect(position.player2).to eq([11, 'x', 11, 1, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(12)
      end
    end
  end

  describe "tuzdyk" do
    context "create tuzdyk" do
      it "if ends of out with 3 kumalaks" do
        position = Position.new(
          [6, 9, 9, 1, 9, 10, 10, 10, 4], 20,
          [3, 2, 2, 0, 9, 9, 9, 9, 9], 22)

        position = position.step(1, 8)

        expect(position.kazan1).to eq(23)
        expect(position.player1).to eq([6, 9, 9, 1, 9, 10, 10, 10, 1])
        expect(position.player2).to eq([4, 3, 'x', 0, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(22)
      end
    end

    context "can't create tuzdyk" do
      it "if already has one" do
        position = Position.new(
          [6, 9, 9, 1, 9, 10, 10, 10, 3], 20,
          [3, 2, 2, 'x', 9, 9, 9, 9, 10], 22)

        position = position.step(1, 8)

        expect(position.kazan1).to eq(20)
        expect(position.player1).to eq([6, 9, 9, 1, 9, 10, 10, 10, 1])
        expect(position.player2).to eq([4, 3, 2, 'x', 9, 9, 9, 9, 10])
        expect(position.kazan2).to eq(22)
      end

      it "if opponent has tuzdyk at the symmetrical otau" do
        position = Position.new(
          [6, 9, 'x', 1, 9, 10, 10, 10, 4], 20,
          [3, 2, 2, 9, 9, 9, 9, 9, 9], 22)

        position = position.step(1, 8)

        expect(position.kazan1).to eq(20)
        expect(position.player1).to eq([6, 9, 'x', 1, 9, 10, 10, 10, 1])
        expect(position.player2).to eq([4, 3, 3, 9, 9, 9, 9, 9, 9])
        expect(position.kazan2).to eq(22)
      end

      it "at ninth otau" do
        position = Position.new(
          [6, 9, 9, 1, 9, 10, 10, 10, 10], 20,
          [3, 2, 2, 1, 9, 9, 9, 9, 2], 22)

        position = position.step(1, 8)

        expect(position.kazan1).to eq(20)
        expect(position.player1).to eq([6, 9, 9, 1, 9, 10, 10, 10, 1])
        expect(position.player2).to eq([4, 3, 3, 2, 10, 10, 10, 10, 3])
        expect(position.kazan2).to eq(22)
      end
    end
  end
end
