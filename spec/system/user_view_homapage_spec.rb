require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome do app' do 
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content 'PaLeva!'

  end
    
end
