require 'rails_helper'

RSpec.describe "User deletes an item through API and" do
  scenario "receives a 204 response if the record is deleted" do
    items = create_list(:item, 5)
    # When I send a DELETE request to `/api/v1/items/1`
    delete '/api/v1/items/1'
    # I receive a 204 JSON response if the record is successfully deleted
    expect(status).to eq 204
    expect(Item.count).to eq 4
  end
end
