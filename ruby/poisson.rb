class PoissonDistribution
  attr_reader :lambda

  def initialize(lambda)
    @lambda = 1.0 * lambda
  end

  def distribution(k)
    lambda ** k * Math.exp( - lambda) / Math.gamma( k + 1 )
  end
end
