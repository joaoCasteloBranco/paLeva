require 'rails_helper'

describe 'User updates a dish' do
  it "with success" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    restaurant = Restaurant.create!(
      user: user,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    login_as(user, :scope => :user)

    patch restaurant_dish_path(restaurant_id: restaurant.id, id: dish.id, params: {
        dish: {
          name: "New Name"
        }
      }
    )


    expect(response).to redirect_to restaurant_dish_path(restaurant_id: restaurant.id, id: dish.id)
  end

  it "but it's not the owner of the restaurant" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    user_2 = User.create!(
      cpf: "662.142.320-99",
      email:  "email@email.com",
      name: "Usuário",
      last_name: "Teste",
      password: "nacoesunidas",
    )

    restaurant = Restaurant.create!(
      user: user,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    restaurant_2 = Restaurant.create!(
      user: user_2,
      registered_name: "Reteteu",
      comercial_name: "Reteteu Restaurante",
      cnpj: "50.934.557/0001-78",
      address: "Av. 1000",
      phone: "6731423872",
      email: "reteteu@restaurante.com"
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    login_as(user_2, :scope => :user)

    patch restaurant_dish_path(restaurant_id: restaurant.id, id: dish.id, params: {
        dish: {
          name: "New Name"
        }
      }
    )

    expect(response).to redirect_to root_path
    follow_redirect!
    expect(response.body).to include 'Acesso negado!'
  end

  it "but its a employee with no permission to create dishes" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    
    restaurant = Restaurant.create!(
      user: user,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    employee = Employee.create!(
      cpf: "662.142.320-99",
      email: "email@email.com",
      status: :pre_registered,
      restaurant: restaurant
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    login_as(employee, :scope => :employee)

    patch restaurant_dish_path(restaurant_id: restaurant.id, id: dish.id, params: {
        dish: {
          name: "New Name"
        }
      }
    )

    expect(response).to redirect_to root_path
    follow_redirect!
    expect(response.body).to include 'Acesso negado!'
  end

  it "but fails because its not logged" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    restaurant = Restaurant.create!(
      user: user,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    patch restaurant_dish_path(restaurant_id: restaurant.id, id: dish.id, params: {
        dish: {
          name: "New Name"
        }
      }
    )


    expect(response).to redirect_to new_user_session_path
    follow_redirect!
    expect(response.body).to include 'Você precisa estar autenticado para acessar esta página.'
  end
end