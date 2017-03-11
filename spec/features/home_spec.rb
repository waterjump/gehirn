require 'rails_helper'

feature 'the home page', type: :feature, js: true do
  before(:each) { visit root_path }

  scenario 'user can access homepage' do
    expect(page.status_code).to eq(200)
  end

  scenario 'user see relevant information' do
    expect(page).to have_field('q')
    expect(page).to have_select('language')
  end
end
