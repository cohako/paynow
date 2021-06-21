require 'rails_helper'

describe 'Visitor try to signup with denied email' do
  it 'user blocked' do
    visit root_path
    click_on 'Sign up user'
    fill_in 'Email', with: 'murilo@gmail.com'
    click_on 'Sign up'

    expect(page).to have_content('Email inválido')
  end
  it 'admin blocked' do
    visit root_path
    click_on 'Sign in Admin'
    click_on 'Sign up'
    fill_in 'Email', with: 'murilo@gmail.com'
    click_on 'Sign up'

    expect(page).to have_content('Email inválido')
  end
end