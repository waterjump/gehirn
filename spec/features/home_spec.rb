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

  scenario 'user enters query' do
    VCR.use_cassette('home') do
      fill_in 'q', with: 'Gehirn'
      expect(page).to have_content('/ɡəˈhɪʁn/')
      expect(page).to have_link('Gehirn')
    end
  end

  scenario 'user enters off-case query' do
    VCR.use_cassette('home') do
      fill_in 'q', with: 'gehirn'
      expect(page).to have_content('/ɡəˈhɪʁn/')
      expect(page).to have_link('Gehirn')
    end
  end
end
