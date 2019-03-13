require 'rails_helper'

feature 'User see more of the post' do
  scenario 'Successfully' do
    user = create(:user)
    post = create(:post, user: user,
                         body: 'Testando a quantidade de linhas para o ler'\
                               'mais. Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'Teste Teste Teste Teste Teste Teste Teste'\
                               'teste teste A partir daqui não aparecerá mais,'\
                               'somente no leia mais')

    visit root_path
    click_on 'Ler mais'

    expect(current_path).to eq post_path(post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
  end

  scenario 'and short posts dont need read more' do
    user = create(:user)
    create(:post, user: user)

    visit root_path

    expect(page).to_not have_content('Ler mais')
  end
end
