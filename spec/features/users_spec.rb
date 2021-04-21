require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:image_name_string) { 'default_user.jpg' }
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'aaaaaaaa' } }
  let(:user) { User.create(user_params) }

  scenario "user creates a new project" do
    visit "/login"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "ログイン"
    visit "/users/#{user.id}/drafts"
    # expect(page).to have_selector(:css, 'a[href=""]')
    expect(page).to have_link("下書き投稿")
  end

end
