require 'rails_helper'

describe 'Visitor try to signup with denied email' do
  it 'blocked' do
    visit root_path
    click_on 'Sign up user'
    fill_in 'Email', with: 'murilo@gmail.com'
    click_on 'Sign up'

    expect(page).to have_content('Email inválido')
  end
end