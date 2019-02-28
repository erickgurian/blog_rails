require 'rails_helper'

feature 'User create a post' do
  scenario 'Successfully' do
    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Postagem'
    fill_in 'Título', with: 'Meu primeiro post'
    fill_in 'Postagem', with: 'Descrição da primeira postagem'
    click_on 'Postar'

    expect(current_path).to eq post_path(1)
    expect(page).to have_content('Post criado com sucesso!')
    expect(page).to have_content('Meu primeiro post')
    expect(page).to have_content('Descrição da primeira postagem')
  end

  scenario 'and must fill all fields' do
    visit root_path
    click_on 'Painel do Usuário'
    click_on 'Nova Postagem'
    fill_in 'Título', with: ''
    fill_in 'Postagem', with: ''
    click_on 'Postar'

    expect(page).to have_content('Todos os campos são obrigatórios')
  end
end
