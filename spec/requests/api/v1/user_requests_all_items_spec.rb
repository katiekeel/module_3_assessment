require 'rails_helper'

RSpec.describe "User requests all items from API and" do
  scenario "receives all items and their attributes" do
    items = create_list(:item, 5)
    # When I send a GET request to `/api/v1/items`
    get '/api/v1/items'
    # I receive a 200 JSON response containing all items
    expect(status).to eq 200

    result = JSON.parse(response.body, :symbolize_names => true)

    expect(result).to be_a Array
    expect(result.count).to eq 5

    # And each item has an id, name, description, and image_url but not the created_at or updated_at
    expect(result.first[:id]).to eq items.first.id
    expect(result.first[:name]).to eq items.first.name
    expect(result.first[:description]).to eq items.first.description
    expect(result.first[:image_url]).to eq items.first.image_url
    expect(result.first).to_not include DateTime

    expect(result.last[:id]).to eq items.last.id
    expect(result.last[:name]).to eq items.last.name
    expect(result.last[:description]).to eq items.last.description
    expect(result.last[:image_url]).to eq items.last.image_url
    expect(result.last).to_not include DateTime
  end
end
