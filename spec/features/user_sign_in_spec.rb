require 'rails_helper'

feature 'User sign in' do
  scenario 'Successfully' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    expect(page).to have_content(user.email)
  end
end
