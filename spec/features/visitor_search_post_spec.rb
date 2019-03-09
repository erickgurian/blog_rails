require 'rails_helper'

feature 'Visitor search a post' do
  scenario 'Successfully' do
    user = create(:user)
    post = create(:post, user: user)

    visit root_path
    fill_in 'Busca', with: post.title
    click_on 'Buscar'

    expect(page).to have_content('1 resultado(s) encontrado(s)!')
    expect(page).to have_link(post.title)
  end

  scenario 'with a part of title' do
    user = create(:user)
    post = create(:post, title: 'Recusividade em Ruby', user: user)
    other_post = create(:post, title: 'Ruby on Rails', user: user)

    visit root_path
    fill_in 'Busca', with: 'Ruby'
    click_on 'Buscar'

    expect(page).to have_content('2 resultado(s) encontrado(s)!')
    expect(page).to have_link(post.title)
    expect(page).to have_link(other_post.title)
  end
end
