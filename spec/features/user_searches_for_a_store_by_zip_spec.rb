require 'rails_helper'

RSpec.describe "User searches for a store by zipcode and" do
  scenario "receives a list of stores within 25 miles and their information" do
    # As a user
    # When I visit "/"
    visit '/'

    # And I fill in a search box with "80202" and click "search"
    fill_in "zip", with: 80202
    click_on "Search"

    # Then my current path should be "/search" (ignoring params)
    expect(current_path).to eq "/search"

    VCR.use_cassette("api/v1/requests/user_searches_for_a_store_by_zip_spec.rb") do
      # And I should see stores within 25 miles of 80202
      response = BestBuyService.find_by_zip(80202, 25)[:stores][0..9]

      # And I should see a message that says "17 Total Stores"
      expect(page).to have_content("17 Stores for 80202")

      # And I should see exactly 10 results
      expect(page).to have_selector('ol li', count: 10)

      # And I should see the long name, city, distance, phone number and store type for each of the 10 results
      expect(page).to have_content response.first[:name].titleize
      expect(page).to have_content response.last[:name].titleize
      expect(page).to have_content response.first[:city]
      expect(page).to have_content response.last[:city]
      expect(page).to have_content "#{response.first[:distance]} Miles Away"
      expect(page).to have_content "#{response.last[:distance]} Miles Away"
      expect(page).to have_content "Phone: #{response.first[:phone]}"
      expect(page).to have_content "Phone: #{response.last[:phone]}"
      expect(page).to have_content "Store Type: #{response.first[:storeType]}"
      expect(page).to have_content "Store Type: #{response.last[:storeType]}"
    end
  end
end
