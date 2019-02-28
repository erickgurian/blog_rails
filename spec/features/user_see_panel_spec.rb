require 'rails_helper'

feature 'User see user panel' do
  scenario 'Successfully' do
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Painel do Usuário'

    expect(current_path).to eq users_path
    expect(page).to have_css('h1', text: "Bem Vindo, #{user.email}")
  end

  scenario 'Only authenticate users can see panel' do
    visit root_path

    expect(page).not_to have_content('Painel do Usuário')
  end

  scenario 'Only authenticate users can see panel - forced' do
    visit users_path

    expect(current_path).to eq root_path
  end

  scenario 'User return to blog' do
    user = create(:user)
    login_as user

    visit users_path
    click_on 'Ver Blog'

    expect(current_path).to eq root_path
  end

  scenario 'and view all your posts' do
    user = create(:user)
    post = create(:post, user: user)
    other_post = create(:post, user: user)
    login_as user

    visit users_path

    expect(page).to have_content('Suas postagens')
    expect(page).to have_content(post.title)
    expect(page).to have_content(other_post.title)
  end

  scenario 'and cant see other user posts' do
    user = create(:user)
    author = create(:user, email: 'author@teste.com')
    post = create(:post, user: author)
    login_as user

    visit users_path

    expect(page).to have_content('Você não possui postagens')
    expect(page).not_to have_content(post.title)
  end
end
