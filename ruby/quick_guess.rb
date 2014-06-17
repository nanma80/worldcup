require File.expand_path('../poisson', __FILE__)
require File.expand_path('../score', __FILE__)
require File.expand_path('../match_model', __FILE__)

match_model = MatchModel.new([0.8, 0.9])
p match_model.best_guess

