require 'game'

RSpec.describe Game, type: :model do

  let(:g) { Game.new }

  def roll_all(num_pins)
    roll_many(20, num_pins)
  end

  def roll_many(num_rolls, num_pins)
    (1..num_rolls).each do
      g.roll(num_pins)
    end
  end

  it 'can have have a gutter game' do
    roll_all(0)
    expect(g.score).to eq 0
  end

  it 'can roll all ones' do
    roll_all(1)
    expect(g.score).to eq 20
  end

  it 'can roll a spare' do
    g.roll(5)
    g.roll(5)
    g.roll(3)
    roll_many(17, 0)
    expect(g.score).to eq 16
  end

  it 'can roll a strike' do
    g.roll(10)
    g.roll(3)
    g.roll(4)
    roll_many(16, 0)
    expect(g.rolls.length).to eq 20
    expect(g.score).to eq 24
  end

  it 'can roll a perfect game' do
    roll_many(12, 10)
    expect(g.rolls.length).to eq 21
    expect(g.score).to eq 300
  end

end