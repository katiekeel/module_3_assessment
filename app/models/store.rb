class Store

  attr_reader :name,
              :city,
              :distance,
              :phone_number,
              :type

  def initialize(raw_store)
    @name = raw_store[:name].titleize
    @city = raw_store[:city]
    @distance = raw_store[:distance]
    @phone_number = raw_store[:phone_number]
    @type = raw_store[:storeType]
  end

  def self.find_by_zip(zipcode, area)
    BestBuyService.find_by_zip(zipcode, area)[:stores].map do |store|
      new(store)
    end
  end

end
