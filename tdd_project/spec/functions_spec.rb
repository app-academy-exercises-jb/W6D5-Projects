require "rspec"
require "functions"


describe Array do 
  # include_examples("test_collections", Array)
  shared_examples("test_collections") do |method|
    it "doesn't mutate original array" do
      arr2 = arr.dup
      arr.send(method)
      expect(arr2).to eql arr
    end
  end

  describe "#my_unique" do 
    include_examples("test_collections", :my_unique)
    let (:arr) { [1,1,2,3] }
    it "strips duplicate elements" do   
      expect(arr.my_unique).to eq(arr.uniq)
    end 
    # check for object uniqueness
  end 

  describe "#two_sum" do
    include_examples("test_collections", :two_sum)
    let (:arr) { [-1, 0, 2, -2, 1] }
    it "returns array of pairs which sum to zero" do
      expect(arr.two_sum).to eq [[0, 4], [2, 3]]
    end

    it "raises TypeError if array contains something other than numbers" do
      expect { ["a"].two_sum }.to raise_error(TypeError)
    end

    it "returns an empty array if no pairs were found" do
      expect([1,2].two_sum).to eq []
    end
  end

  describe "#my_transpose" do
    include_examples("test_collections", :my_transpose)
    let (:rows) { [[0, 1, 2],[3, 4, 5],[6, 7, 8]] }
    let (:cols) { [[0, 3, 6],[1, 4, 7],[2, 5, 8]] }
    let (:arr) {rows}

    it "returns the columns of a 2D array" do
      expect(rows.my_transpose).to eq cols
    end

    it "raises IndexError unless all subarrays are of equal length" do
      expect { [[1,2],[1]].my_transpose }.to raise_error(IndexError)
    end

    it "raises TypeError if not a 2D array" do
      expect { [[1,2],1].my_transpose }.to raise_error(TypeError)
    end
  end
end

describe "#stock_picker" do
  let (:stock) { [351, 10, 330, 200, 455, 372, 246, 307, 271, 232, 404, 489, 86, 421, 226, 37, 292, 70, 420, 420, 395, 406, 20, 13, 419, 384, 123, 71, 247, 96] }

  it "returns best pair of days to purchase and sell stock" do
    expect(stock_picker(stock)).to eq [2,11]
  end

  it "raises ArgumentError when given anything other than an array containing numbers" do 
    expect {stock_picker([1, "a"])}.to raise_error(ArgumentError)
  end 

  it "returns an empty array if given an unary array" do 
    expect(stock_picker([1])).to eq []
  end 
end

describe HanoiGame do
  subject(:hanoi) { HanoiGame.new }

  describe "#move" do
    it "moves correctly" do 
      hanoi.move([0,1])
      expect(hanoi.board).to eq [[4,3,2],[1],[]]
    end

    it "only allows legal movements" do
      hanoi.move([0,1])
      expect { hanoi.move([0,1]) }.to raise_error(RuntimeError, "move not allowed")
    end

    it "only allows movements from occupied positions" do 
      expect { hanoi.move([1,0]) }.to raise_error(RuntimeError, "there's no piece there")
    end 
  end

  describe "won?" do
    let (:board) {[[],[],[4,3,2,1]]} 
    it "recognises win conditions" do
      hanoi.instance_variable_set(:@board, board)
      expect(hanoi.won?).to eq true
    end
    it "recognises non-win conditions" do 
      expect(hanoi.won?).to eq false
    end 
  end
end