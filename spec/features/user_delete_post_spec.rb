require 'rails_helper'

feature 'User deletes a post' do
  scenario 'Successfully' do
    user = create(:user)
    post = create(:post, user: user)
    login_as user

    visit root_path
    click_on 'Apagar'

    expect(page).not_to have_content(post.title)
    expect(page).not_to have_content(post.title)
  end
end
