require 'rails_helper'

RSpec.feature "User login/logout" do
  before do
    mock_auth_hash
  end

  scenario "login with foursquare credentials" do
    visit '/'

    expect(page.status_code).to eq(200)

    click_link "Login with Foursquare"

    expect(current_path).to eq("/")
    expect(page).to have_content("mockuser")
    expect(page).to have_link("Logout")
  end

  scenario "user can log out" do
    visit "/"

    click_link "Login with Foursquare"

    click_on "Logout"
    expect(current_path).to eq("/")
    expect(page).to have_content("Login with Foursquare")
  end
end
