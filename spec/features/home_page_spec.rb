require 'rails_helper'

RSpec.feature "HomePages", type: :feature do
 scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    save_screenshot
  end
end
