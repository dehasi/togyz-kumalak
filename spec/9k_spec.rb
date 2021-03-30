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
end
