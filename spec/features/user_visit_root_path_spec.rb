require 'rails_helper'

feature 'User visit root path' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_content('Blog do Erick')
    expect(page).to have_css('h3', text: 'Ainda não há postagens!')
  end

  scenario 'and see recently posts' do
    user = create(:user)
    post = create(:post, user: user)

    visit root_path

    expect(page).to have_css('h4', text: post.title)
    expect(page).to have_css('p', text: post.body)
    expect(page).not_to have_content('Ainda não há postagens!')
  end
end
