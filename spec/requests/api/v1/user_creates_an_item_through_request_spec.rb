require 'rails_helper'

RSpec.describe "User creates an item through API and" do
  scenario "receives a 201 response with the new item and its attributes" do
    items = create_list(:item, 5)
    new_item = {name: "New Item Name",
                description: "New Item Description",
                image_url: "New Item Image Url"}
    # When I send a POST request to `/api/v1/items` with a name, description, and image_url
    post '/api/v1/items', new_item
    # I receive a 201 JSON  response if the record is successfully created
    expect(status).to eq 201
    expect(Item.count).to eq 6
    new_item = Item.last
    # And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at
    result = JSON.parse(response.body, :symbolize_names => true)

    expect(result[:name]).to eq new_item.name
    expect(result[:description]).to eq new_item.description
    expect(result[:image_url]).to eq new_item.image_url
    expect(result).to_not include DateTime
  end
end
