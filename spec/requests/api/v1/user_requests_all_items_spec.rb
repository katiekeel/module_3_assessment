require 'rails_helper'

RSpec.describe "User requests all items from API and" do
  scenario "receives all items and their attributes" do
    get '/api/v1/items'
    # When I send a GET request to `/api/v1/items`
    # I receive a 200 JSON response containing all items
    VCR.use_cassette("api/v1/requests/user_visits_destination_page_spec.rb") do

      expect(status).to eq 200
      result = JSON.parse(response.body, :symbolize_names => true)
      expect(result).to be_a Array

      # And each item has an id, name, description, and image_url but not the created_at or updated_at
      expect(result.first[:id]).to eq Item.first.id
      expect(result.first[:name]).to eq Item.first.name
      expect(result.first[:description]).to eq Item.first.description
      expect(result.first[:image_url]).to eq Item.first.image_url
      expect(result.first).to_not include DateTime

      expect(result.last[:id]).to eq Item.last.id
      expect(result.last[:name]).to eq Item.last.name
      expect(result.last[:description]).to eq Item.last.description
      expect(result.last[:image_url]).to eq Item.last.image_url
      expect(result.last).to_not include DateTime
    end
  end
end
