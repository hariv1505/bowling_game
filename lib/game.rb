class Game
  attr_accessor :rolls

  MAX_FRAMES = 10

  def initialize
    self.rolls = Array.new
  end

  def roll(pins)
    rolls << pins
    if pins == 10 && frames.length != MAX_FRAMES
      rolls << nil
    end
  end

  def frames
    frames = []
    rolls.each_with_index do |r,i|
      frame_index = [i/2, MAX_FRAMES-1].min
      frames[frame_index] ||= []
      frames[frame_index] << r
    end
    frames
  end

  def score
    sum = 0
    frames.each_with_index do |frame_rolls, i|
      score = frame_rolls.reduce(0) { |s,p| s + (p || 0) }
      sum += score
      is_spare = score == 10
      is_strike = score == 10 && frame_rolls[1].nil?
      unless frames[i+1].nil?
        if is_strike
          next_rolls = rolls.drop((i+1)*2)
          sum += next_rolls.compact.first(2).reduce(0) { |s,p| s + p }
        elsif is_spare
          sum += frames[i+1].first
        end
      end
    end
    sum
  end
end