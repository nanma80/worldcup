class MatchModel
  attr_reader :lambdas, :distributions, :outcomes

  def initialize(lambdas)
    @lambdas = lambdas
    @distributions = []
    lambdas.each do |lambda|
      @distributions << PoissonDistribution.new(lambda)
    end
    @outcomes = {a: 0, draw: 0, b: 0}
    build_outcomes
  end

  def score_probability(score)
    prob = 1.0
    score.to_a.each_with_index do |s, index|
      prob *= distributions[index].distribution(s)
    end
    prob
  end

  def outcome_probability(score)
    @outcomes[score.winner]
  end

  def yahoo_score(score)
    2.0 * outcome_probability(score) + 2.0 * score_probability(score)
  end

  def build_outcomes
    Score.all do |score|
      winner = score.winner
      @outcomes[winner] += score_probability(score)
    end    
  end

  def best_guess
    best_score_so_far = 0.0
    best_guess_so_far = ''

    Score.all do |score|
      s = yahoo_score(score)
      if s > best_score_so_far
        best_score_so_far = s
        best_guess_so_far = score.to_s
      end
    end

    {guess: best_guess_so_far, yahoo_score: best_score_so_far}
  end
end
