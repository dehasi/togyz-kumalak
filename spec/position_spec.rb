require "position"

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

      it "all kumalaks go to kazan2" do
         position = Position.new([9, 9, 9, 9, 1, 10, 10, 10, 10], 10, [10, 10, 10, 0, 9, 9, 9, 9, 9], 0)

         position = position.step(2, 0)

         expect(position.kazan1).to eq(10)
         expect(position.player1).to eq([0, 9, 9, 9, 1, 10, 10, 10, 10])
         expect(position.player2).to eq([1, 11, 11, 1, 10, 10, 10, 10, 10])
         expect(position.kazan2).to eq(10)
      end
#p1: step 5 -> 4
#P2:[9, 9, 9, 9, 9, 0, 10, 10, 10]
#Kazan1: 10          Kazan2: 0
#P1:[9, 9, 9, 9, 1, 10, 10, 10, 10]
    end
  end
end
