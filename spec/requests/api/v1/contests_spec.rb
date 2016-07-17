require 'rails_helper'

describe "GET /contests" do
  it "returns all contests" do
    FactoryGirl.create_list(:contest, 5)

    get '/api/v1/contests'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['contests'].length).to eq(5)
  end
end
