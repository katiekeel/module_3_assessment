class Store

  def initialize(raw_store)
    @name = raw_store[:name]
    @city = raw_store[:city]
    @distance = raw_store[:distance]
    @phone_number = raw_store[:phone_number]
    @type = raw_store[:type]
  end

  def self.find_by_zip(zipcode, area)
    BestBuyService.find_by_zip(zipcode, area).each do |store|
      new(store)
    end
  end

end
