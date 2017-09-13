require 'rails_helper'

RSpec.describe "User requests all items from API and" do
  scenario "receives all items and their attributes" do
    # When I send a GET request to `/api/v1/items`
    get '/api/v1/items'
    # I receive a 200 JSON response containing all items
    expect(status).to eq 200
    result = JSON.parse(response.body)
    expect(result).to be_a Hash
    expect(result.count).to eq 500
    # And each item has an id, name, description, and image_url but not the created_at or updated_at
    expect(result.first.id).to eq 1
    expect(result.first.name).to eq "Intelligent Plastic Gloves"
    expect(result.first.description).to include "Harum fuga omnis et eius."
    expect(result.first.image_url).to eq "http://robohash.org/0.png?set=set2&bgset=bg1&size=200x200"
    expect(result.first).to exclude DateTime
    expect(result.last.id).to eq 500
    expect(result.last.name).to eq "Rustic Concrete Gloves"
    expect(result.last.description).to include "Eos excepturi quia mollitia."
    expect(result.last.image_url).to eq "http://robohash.org/499.png?set=set2&bgset=bg1&size=200x200"
    expect(result.last).to exclude DateTime

  end
end
