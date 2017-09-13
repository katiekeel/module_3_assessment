class BestBuyService

  attr_reader :zip

  def initialize(zip)
    @zip = zip
    @conn = Faraday.new(url: "https://api.bestbuy.com/v1/") do |faraday|
      # faraday.headers["X-API-KEY"] = ENV["MYSTERY_KEY"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    byebug
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_by_zip(zipcode, area)
    new(zipcode).find_stores_by_zipcode(zipcode, area)
  end

  def find_stores_by_zipcode(zipcode, area)
    get_url("stores((area(#{zipcode},#{area})))?apiKey=#{ENV["MYSTERY_KEY"]}&format=json")
  end

end
