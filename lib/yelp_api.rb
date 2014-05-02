require 'oauth'

class YelpSession
  
  def initialize
    @consumer = OAuth::Consumer.new(ENV["YELP_KEY"], ENV["YELP_SECRET"], {site: "http://api.yelp.com"})
    @access_token = OAuth::AccessToken.new(@consumer, ENV["YELP_TOKEN"], ENV["YELP_TOKEN_SECRET"])
    @path = "/v2/search?term=restaurants&location=new%20york"
  end
  
  def get_json_response
    response = @access_token.get(@path).body
    JSON.parse(response)
  end
  
end