require 'net/http'
require 'json'

class Match
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def html_url
    'http://www.oddschecker.com/football/world-cup/' + id + '/correct-score'
  end

  def html_body
    url = URI.parse(html_url)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    res.body  
  end

  def bet_data(testing = false)
    if testing
      return [["Croatia 2-0 (8/1)", 31], ["Croatia 2-1 (17/2)", 26], ["Croatia 1-0 (13/2)", 16], ["Draw 0-0 (11/1)", 15], ["Croatia 3-1 (15/1)", 14], ["Draw 1-1 (7/1)", 9], ["Draw 3-3 (150/1)", 8], ["Cameroon 2-1 (18/1)", 6], ["Draw 2-2 (20/1)", 6], ["Croatia 3-2 (33/1)", 5], ["Croatia 3-0 (14/1)", 4], ["Cameroon 3-1 (60/1)", 4], ["Croatia 4-2 (80/1)", 4], ["Cameroon 1-0 (13/1)", 3], ["Cameroon 2-0 (30/1)", 3], ["Croatia 4-1 (35/1)", 3], ["Cameroon 3-2 (70/1)", 3], ["Croatia 4-0 (35/1)", 2], ["Croatia 5-1 (110/1)", 1], ["Cameroon 4-2 (250/1)", 1], ["Draw 4-4 (400/1)", 1]]
    end
    html_body.each_line do |line|
      if line.include? 'oc.charts.push'
        json_string = line[19..-4]
        return JSON.parse(json_string)['data']
      end
    end
    raise 'Cannot find betting data'
  end


end
