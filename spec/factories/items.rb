FactoryGirl.define do
  factory :item do
    sequence :name do |x|
      "Item #{x}"
    end

    sequence :description do |x|
      "Description #{x}"
    end

    image_url "http://google.com"
  end
end
