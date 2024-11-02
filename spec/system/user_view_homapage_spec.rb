require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome do app' do 
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_link 'PaLeva!'

  end
    
end
