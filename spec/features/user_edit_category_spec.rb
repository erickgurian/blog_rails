require 'rails_helper'

feature 'User edit category' do
  scenario 'successfully' do
    user = create(:user)
    category = create(:category)
    login_as user

    visit categories_path
    click_on 'Editar'
    fill_in 'Nome', with: 'Chorão skate'
    click_on 'Editar'

    expect(current_path).to eq categories_path
    expect(page).to have_content('Chorão skate')
    expect(page).not_to have_content(category.name)
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    create(:category)
    login_as user

    visit categories_path
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Editar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and cant have two equals names' do
    user = create(:user)
    category = create(:category)
    create(:category, name: 'Mobile')
    login_as user

    visit edit_category_path(category)
    fill_in 'Nome', with: 'Mobile'
    click_on 'Editar'

    expect(page).to have_content('Este nome já existe')
  end
end
