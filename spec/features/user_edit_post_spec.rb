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
end
