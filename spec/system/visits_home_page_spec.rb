require 'rails_helper'

describe 'Visitant visits homepage' do
  it 'successfully' do
    visit root_path

   	expect(current_path).to eq(root_path)
		expect(page).to have_content('Bem vindo ao paynow')
  end 
end