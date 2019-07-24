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

  scenario 'only author can delete' do
    user = create(:user)
    author = create(:user, email: 'author@test.com')
    post = create(:post, user: author)
    login_as user

    visit post_path(post)

    expect(page).not_to have_content('Apagar')
  end

  scenario 'only author can delete - forced' do
    user = create(:user)
    author = create(:user, email: 'author@test.com')
    post = create(:post, user: author)
    login_as user

    page.driver.submit :delete, "/posts/#{post.id}", {}

    expect(current_path).to eq root_path
    expect(page).to have_content(post.title)
  end

  scenario 'visitor cant delete' do
    user = create(:user)
    post = create(:post, user: user)

    visit post_path(post)

    expect(page).not_to have_content('Apagar')
  end

  scenario 'visitor cant delete - forced' do
    user = create(:user)
    post = create(:post, user: user)

    page.driver.submit :delete, "/posts/#{post.id}", {}

    expect(current_path).to eq root_path
    expect(page).to have_content(post.title)
  end
end
