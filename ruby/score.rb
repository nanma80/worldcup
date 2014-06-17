class Score
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def to_a
    [a, b]
  end

  def to_s
    "#{a}-#{b}"
  end

  def winner
    if a > b
      :a
    elsif a < b
      :b
    else
      :draw
    end
  end

  def self.all
    limit = 30
    limit.times do |a_score|
      limit.times do |b_score|
        yield Score.new(a_score, b_score)
      end
    end
  end
end
