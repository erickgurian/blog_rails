require 'rails_helper'

feature 'User creates category' do
  scenario 'Successfully' do
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Categoria'
    fill_in 'Nome', with: 'Programação'
    click_on 'Criar'

    expect(current_path).to eq categories_path
    expect(page).to have_content('Categoria criada com sucesso!')
    expect(page).to have_css('td', text: 'Programação')
  end

  scenario 'and see all categories' do
    user = create(:user)
    category = create(:category, name: 'Programação')
    other_category = create(:category, name: 'Programação Web')
    login_as user

    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Ver Categorias'

    expect(current_path).to eq categories_path
    expect(page).to have_css('h4', text: 'Categorias')
    expect(page).to have_css('td', text: category.name)
    expect(page).to have_css('td', text: other_category.name)
  end

  scenario 'and see all categories on initial page' do
    category = create(:category, name: 'Programação')
    other_category = create(:category, name: 'Programação Web')

    visit root_path

    expect(page).to have_content(category.name)
    expect(page).to have_content(other_category.name)
  end

  scenario 'and see all posts of that category' do
    user = create(:user)
    category = create(:category)
    post = create(:post, user: user)
    category.posts << post
    login_as user

    visit root_path
    click_on category.name

    expect(current_path).to eq category_path(category)
    expect(page).to have_link(post.title)
    expect(page).to have_content(post.body)
  end

  scenario 'and see no posts of that category' do
    user = create(:user)
    category = create(:category)
    login_as user

    visit root_path
    click_on category.name

    expect(current_path).to eq category_path(category)
    expect(page).to have_css('h3', text: 'Não há postagens nessa categoria')
  end
end
