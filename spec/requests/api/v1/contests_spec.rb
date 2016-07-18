require 'rails_helper'

describe "GET /contests" do
  it "should return all contests" do
    FactoryGirl.create_list(:contest, 5)

    get api_v1_contests_path

    expect(response).to be_success
    expect(json.length).to eq(5)
  end
end
