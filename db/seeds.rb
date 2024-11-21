# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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

serving_1 = Serving.create!(
  menu_item: dish,
  price: 1000,
  description: 'Porção Teste (600g)'
)

serving_2 = Serving.create!(
  menu_item: dish,
  price: 2000,
  description: 'Porção Teste (1200g)'
)

beverage = Beverage.create!(
  restaurant: restaurant, 
  name: "Bebida Teste",
  description: 'Uma descrição do prato de teste.',
  calories: 300,
  alcoholic: false
)

serving_3 = Serving.create!(
  menu_item: beverage,
  price: 1000,
  description: 'Recipiente Teste (150ml)'
)

serving_4 = Serving.create!(
  menu_item: beverage,
  price: 2000,
  description: 'Recipiente Teste (300ml)'
)

red_wine = Beverage.create!(
  restaurant: restaurant, 
  name: "Vinho Tinto",
  description: 'Vinho seco e forte',
  calories: 100,
  alcoholic: true
)

red_wine_serving_1 = Serving.create!(
  menu_item: red_wine,
  price: 1000,
  description: 'Taça (100ml)'
)

red_wine_serving_2 = Serving.create!(
  menu_item: red_wine,
  price: 2000,
  description: 'Garrafa (750ml)'
)

wine_list = Menu.create!(
  name: "Carta de Vinhos",
  restaurant: restaurant
)

MenuContent.create!(
  menu: wine_list,
  menu_item: red_wine
)


order_1 = Order.create!(
  restaurant: restaurant,
  customer_name: 'João',
  contact_phone: "6731423872",
  contact_email: 'joao.silva@email.com',
  cpf: '109.789.030-99',
)

order_item = OrderItem.create!(
  order: order_1,
  serving: serving_1,
  note: "Sem Cebola"
)

order_item_2 = OrderItem.create!(
  order: order_1,
  serving: serving_2,
  note: "Com Cebola"
)

order_2 = Order.create!(
  restaurant: restaurant,
  customer_name: 'Carlos',
  contact_phone: "6731423873",
  contact_email: 'carlos.silva@email.com',
  cpf: '662.142.320-99',
  status: :canceled
)

order_item_3 = OrderItem.create!(
  order: order_2,
  serving: serving_3,
  note: "Fria"
)

order_item_4 = OrderItem.create!(
  order: order_2,
  serving: serving_4,
  note: "Quente"
)

order_3 = Order.create!(
  restaurant: restaurant,
  customer_name: 'Junior',
  contact_phone: "6731423875",
  contact_email: 'junior.silva@email.com',
  cpf: '662.142.320-99',

)