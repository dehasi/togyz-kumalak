require "9k"

describe Position do

  describe "initial position" do
    context "at the beginnig of the game" do
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
    end
  end
end
