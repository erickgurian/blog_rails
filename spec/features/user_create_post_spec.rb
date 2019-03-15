require 'rails_helper'

feature 'User create a post' do
  scenario 'Successfully' do
    user = create(:user)
    category = create(:category)
    login_as user

    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Postagem'
    fill_in 'Título', with: 'Meu primeiro post'
    fill_in 'Postagem', with: 'Descrição da primeira postagem'
    check category.name
    click_on 'Postar'

    expect(current_path).to eq post_path(1)
    expect(page).to have_content('Post criado com sucesso!')
    expect(page).to have_content('Meu primeiro post')
    expect(page).to have_content('Descrição da primeira postagem')
    expect(page).to have_css('p', text: category.name)
    expect(page).to have_content("Por: #{user.email}")
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Postagem'
    fill_in 'Título', with: ''
    fill_in 'Postagem', with: ''
    click_on 'Postar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Postagem não pode ficar em branco')
  end

  scenario 'and only authenticate user can create a post' do
    visit root_path

    expect(page).not_to have_content('Painel do Usuário')
  end

  scenario 'and only authenticate user can create a post - forced' do
    visit new_post_path

    expect(current_path).to eq root_path
  end

  scenario 'and selec more than one categories' do
    user = create(:user)
    category = Category.create(name: 'Mobile')
    other_category = Category.create(name: 'Web')
    login_as user

    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Postagem'
    fill_in 'Título', with: 'Meu primeiro post'
    fill_in 'Postagem', with: 'Descrição da primeira postagem'
    check 'Mobile'
    check 'Web'
    click_on 'Postar'

    expect(current_path).to eq post_path(1)
    expect(page).to have_content('Post criado com sucesso!')
    expect(page).to have_content('Meu primeiro post')
    expect(page).to have_content('Descrição da primeira postagem')
    expect(page).to have_css('p', text: category.name)
    expect(page).to have_css('p', text: other_category.name)
    expect(page).to have_content("Por: #{user.email}")
  end
end
