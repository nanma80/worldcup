require File.expand_path('../poisson', __FILE__)
require File.expand_path('../score', __FILE__)
require File.expand_path('../match_model', __FILE__)

# match_model = MatchModel.new([3.0, 3.0])
# p match_model.best_guess

limit = 20
precision = 5.0

guesses = []
limit.times do |a_index|
  row = []
  limit.times do |b_index|
    a_lambda = a_index / precision
    b_lambda = b_index / precision
    match_model = MatchModel.new([a_lambda, b_lambda])
    
    row << match_model.best_guess[:guess]

  end
  guesses << row
end

guesses.each do |row|
  p row
end

