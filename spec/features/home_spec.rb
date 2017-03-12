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

  scenario 'no sound for query' do
    VCR.use_cassette('home') do
      fill_in 'q', with: 'Nichtraucherinnen'
      expect(page).to have_content('/ˈnɪçtˌʀaʊ̯χəʀɪnən/')
      expect(page).to have_content('No audio found.')
    end
  end

  scenario 'no result for query' do
    VCR.use_cassette('home') do
      fill_in 'q', with: 'Myfakeword'
      expect(page).to have_content('No results.')
    end
  end

  scenario 'shows language-specific audio only' do
    VCR.use_cassette('home') do
      fill_in 'q', with: 'gift'
      expect(page).to have_content('No audio found.')
      fill_in 'q', with: 'Gift'
      expect(find_link('Gift')[:href])
        .to eq('http://upload.wikimedia.org/wikipedia/commons/0/01/De-Gift.ogg')
    end
  end

end
