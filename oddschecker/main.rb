require File.expand_path('../match', __FILE__)

match_id = 'cameroon-v-croatia'

match = Match.new(match_id)

p match.bet_data(true)

