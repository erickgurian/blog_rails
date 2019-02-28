require 'rails_helper'

feature 'User visit root path' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_content('Blog do Erick')
  end
end
