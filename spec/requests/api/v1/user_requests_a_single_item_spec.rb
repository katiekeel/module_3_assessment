require 'rails_helper'

RSpec.describe "User requests a single item from API and" do
  scenario "receives the items and its attributes" do
    # When I send a GET request to `/api/v1/items/1`
    get '/api/v1/items/1'
    # I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at
    expect(status).to eq 200

    result = JSON.parse(response.body, :symbolize_names => true)
    
    expect(result).to be_a Hash
    expect(result[:id]).to eq Item.first.id
    expect(result[:name]).to eq Item.first.name
    expect(result[:description]).to eq Item.first.description
    expect(result[:image_url]).to eq Item.first.image_url
    expect(result).to_not include DateTime
  end
end
