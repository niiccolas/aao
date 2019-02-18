require 'my_methods'

describe 'my_uniq' do
  let(:dups_array) { [1, 1, 2, 2, 2, 2, 2, 3] }
  let(:no_dups_array) { [1, 2, 3] }
  subject(:removed_dups) { my_uniq(dups_array) }

  it 'returns an array' do
    expect(removed_dups).to be_an_instance_of(Array)
  end

  it 'removes duplicates' do
    dups_array.all? do |el|
      expect(removed_dups.count(el)).to eq(1)
    end
  end

  it "does not modify the array it's called on" do
    expect { my_uniq(dups_array) }.to_not(change { dups_array })
  end
end

describe 'two_sum' do
  let(:rando_array) { Array.new(5) { rand(-2..5) } }
  let(:fixed_array) { [0, 1, 0, 3, -1]}
  subject { two_sum(rando_array) }

  it 'returns an array' do
    expect(subject).to be_an_instance_of(Array)
  end

  it 'returns an array of pairs' do
    expect(subject.all? { |pair| pair.size == 2 }).to eq(true)
  end

  it 'finds indices of zero-sum pairs' do
    expect(two_sum(fixed_array)).to eq([[0, 2], [1, 4]])
  end

  it 'sorts pairs dictionary-wise' do
    expect(subject).to eq(subject.sort)
  end
end

describe 'my_transpose' do
  let(:grid) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ] }
  let(:grid_transposed) { [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]
  }
  subject { my_transpose(grid) }

  it 'returns an array' do
    expect(subject).to be_an_instance_of(Array)
  end

  it "maintains the grid's aspect ratio" do
    expect(subject.length).to eq(grid.length)
  end

  it 'turns a row into a column' do
    expect(grid[0][0]).to eq(subject[0][0])
    expect(grid[0][1]).to eq(subject[1][0])
    expect(grid[0][2]).to eq(subject[2][0])
  end
end

describe '#stock_picker' do
  let(:stock) { Array.new(10) { rand(0.0..250.0).round 2 } }
  let(:best_buy_day) { stock.index(stock.min) }
  let(:best_sell_day) { stock.index(stock[best_buy_day..-1].max) }
  subject { stock_picker(stock) }

  it 'does not buy during a crash' do
    expect { stock_picker([5, 4, 3, 2, 1]) }.to raise_error('Stock is crashing, do not buy')
  end

  it 'returns an array of pairs' do
    expect(subject).to be_an_instance_of(Array)
    expect(subject.length).to eq(2)
  end

  it 'takes an array of Integers or Floats' do
    subject.each do |price|
      expect(price).to be_an_instance_of(Integer).or be_an_instance_of(Float)
    end
  end

  context 'it returns the most profitable day' do
    it 'first, on which to buy' do
      expect(subject.first).to eq(stock.index(stock.min))
    end
    it 'second, on which to sell' do
      expect(subject.last).to eq(best_sell_day)
    end
  end

  it 'only sells after having bought' do
    expect(subject.last).to be >= subject.first
  end
end
