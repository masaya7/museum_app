module LoginMacros
  def login_as(user)
    visit root_path
    click_link('ログイン')
    fill_in 'session[email]', with: 'sample@sample.com'
    fill_in 'session[password]', with: 'password'
    click_button('ログインする')
  end
end