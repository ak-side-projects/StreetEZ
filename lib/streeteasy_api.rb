class StreetEasySession
  def self.path_to_url
    url = Addressable::URI.new(
        :scheme => "http",
        :host => "streeteasy.com",
        :path => "/nyc/api/rentals/data",
        :query_values => {
          criteria: 'rental_type:frbo,brokernofee,brokerfee|area:115,117,158,113,116,118,109,107,105,157',
          key: ENV["STREETEASY_KEY"],
          format: 'json'
        }).to_s
  end
  
  def self.get(path, query_values = nil)
    url = path_to_url
    response = JSON.parse(RestClient.get(url))
    response
  end
end


# http://streeteasy.com/for-rent/nyc/rental_type:frbo,brokernofee,brokerfee%7Carea:115,117,158,113,116,118,109,107,105,157

# http://streeteasy.com/nyc/api/sales/data?criteria=area:soho-manhattan|beds:3&key=2d0690798140c634ff1821c5d24152da2fa0b7b0&format=json


# http://streeteasy.com/nyc/api/rentals/data?rental_type:frbo,brokernofee,brokerfee|area:115,117,158,113,116,118,109,107,105,157&key=2d0690798140c634ff1821c5d24152da2fa0b7b0&format=json