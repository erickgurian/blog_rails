require 'rails_helper'

feature 'User edit post' do
  scenario 'Successfully' do
    user = create(:user)
    post = create(:post, user: user)
    login_as user

    visit post_path(post)
    click_on 'Editar'
    fill_in 'Título', with: 'Título Editado'
    fill_in 'Postagem', with: 'Postagem editada'
    click_on 'Editar'

    expect(current_path).to eq post_path(post)
    expect(page).to have_content('Postagem editada com sucesso')
    expect(page).to have_css('h4', text: 'Título Editado')
    expect(page).to have_css('p', text: 'Postagem editada')
  end

  scenario 'and must fill all field' do
    user = create(:user)
    post = create(:post, user: user)
    login_as user

    visit post_path(post)
    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Postagem', with: ''
    click_on 'Editar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Postagem não pode ficar em branco')
  end

  scenario 'only author can edit a post' do
    user = create(:user)
    author = create(:user, email: 'author@test.com')
    create(:post, user: author)
    login_as user

    visit root_path

    expect(page).not_to have_content('Editar')
  end

  scenario 'only author can edit a post - forced' do
    user = create(:user)
    author = create(:user, email: 'author@test.com')
    post = create(:post, user: author)
    login_as user

    visit edit_post_path(post)

    expect(current_path).to eq root_path
  end

  scenario 'and select a category' do
    user = create(:user)
    category = create(:category)
    post = create(:post, user: user)
    login_as user

    visit post_path(post)
    click_on 'Editar'
    fill_in 'Título', with: 'Título Editado'
    fill_in 'Postagem', with: 'Postagem editada'
    check category.name
    click_on 'Editar'

    expect(current_path).to eq post_path(post)
    expect(page).to have_content('Postagem editada com sucesso')
    expect(page).to have_css('h4', text: 'Título Editado')
    expect(page).to have_css('p', text: 'Postagem editada')
    expect(page).to have_css('p', text: category.name)
  end
end
