# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user_1 = User.find_or_create_by!(cpf: "109.789.030-99") do |user|
  user.email = "sergio.vieira.de.melo@ri.com"
  user.name = "Sergio"
  user.last_name = "Vieira"
  user.password = "nacoesunidas"
end

user_2 = User.find_or_create_by!(cpf: "047.086.700-01") do |user|
  user.email = "ana.paula@exemplo.com"
  user.name = "Ana"
  user.last_name = "Paula"
  user.password = "senhaSegura123"
end

# Criação de restaurantes
restaurant_1 = Restaurant.find_or_create_by!(cnpj: "61.236.299/0001-72") do |restaurant|
  restaurant.user = user_1
  restaurant.registered_name = "Arvo LTDA"
  restaurant.comercial_name = "Arvo Restaurante"
  restaurant.address = "Av. 1000"
  restaurant.phone = "6731423872"
  restaurant.email = "arvo@restaurante.com"
end

restaurant_2 = Restaurant.find_or_create_by!(cnpj: "40.884.396/0001-00") do |restaurant|
  restaurant.user = user_2
  restaurant.registered_name = "Delícias da Serra"
  restaurant.comercial_name = "Serra Gourmet"
  restaurant.address = "Rua da Serra, 456"
  restaurant.phone = "6731421234"
  restaurant.email = "contato@serragourmet.com"
end

# Criação de pratos
dish_1 = Dish.find_or_create_by!(name: "Prato Executivo", restaurant: restaurant_1) do |dish|
  dish.description = "Um prato balanceado com arroz, feijão e carne."
  dish.calories = 550
end

dish_2 = Dish.find_or_create_by!(name: "Salada Verde", restaurant: restaurant_1) do |dish|
  dish.description = "Uma combinação fresca de folhas e legumes."
  dish.calories = 200
end

dish_3 = Dish.find_or_create_by!(name: "Peixe Grelhado", restaurant: restaurant_2) do |dish|
  dish.description = "Peixe grelhado com ervas e legumes."
  dish.calories = 400
end

dish_4 = Dish.find_or_create_by!(name: "Risoto de Cogumelos", restaurant: restaurant_2) do |dish|
  dish.description = "Risoto cremoso com cogumelos selecionados."
  dish.calories = 350
end

# Criação de porções para pratos
Serving.find_or_create_by!(menu_item: dish_1, description: "Porção Individual") do |serving|
  serving.price = 1500
end

Serving.find_or_create_by!(menu_item: dish_2, description: "Porção Familiar") do |serving|
  serving.price = 2500
end

Serving.find_or_create_by!(menu_item: dish_3, description: "Porção Simples") do |serving|
  serving.price = 1800
end

Serving.find_or_create_by!(menu_item: dish_4, description: "Porção Gourmet") do |serving|
  serving.price = 2200
end

# Criação de bebidas
beverage_1 = Beverage.find_or_create_by!(name: "Suco Natural", restaurant: restaurant_1) do |beverage|
  beverage.description = "Suco fresco e saudável."
  beverage.calories = 120
  beverage.alcoholic = false
end

beverage_2 = Beverage.find_or_create_by!(name: "Cerveja Artesanal", restaurant: restaurant_2) do |beverage|
  beverage.description = "Uma cerveja artesanal de alta qualidade."
  beverage.calories = 180
  beverage.alcoholic = true
end

beverage_3 = Beverage.find_or_create_by!(name: "Água com Gás", restaurant: restaurant_1) do |beverage|
  beverage.description = "Água mineral com gás."
  beverage.calories = 0
  beverage.alcoholic = false
end

beverage_4 = Beverage.find_or_create_by!(name: "Vinho Branco", restaurant: restaurant_2) do |beverage|
  beverage.description = "Vinho branco suave."
  beverage.calories = 120
  beverage.alcoholic = true
end

# Criação de porções para bebidas
Serving.find_or_create_by!(menu_item: beverage_1, description: "Copo 300ml") do |serving|
  serving.price = 800
end

Serving.find_or_create_by!(menu_item: beverage_2, description: "Garrafa 600ml") do |serving|
  serving.price = 2500
end

Serving.find_or_create_by!(menu_item: beverage_3, description: "Garrafa 500ml") do |serving|
  serving.price = 600
end

Serving.find_or_create_by!(menu_item: beverage_4, description: "Taça 150ml") do |serving|
  serving.price = 1200
end

# Criação de menus
menu_1 = Menu.find_or_create_by!(name: "Menu Executivo", restaurant: restaurant_1)
menu_2 = Menu.find_or_create_by!(name: "Menu Especial", restaurant: restaurant_2)
menu_3 = Menu.find_or_create_by!(name: "Carta de Vinhos", restaurant: restaurant_2)

# Adicionando itens ao menu
MenuContent.find_or_create_by!(menu: menu_1, menu_item: dish_1)
MenuContent.find_or_create_by!(menu: menu_1, menu_item: beverage_1)
MenuContent.find_or_create_by!(menu: menu_2, menu_item: dish_3)
MenuContent.find_or_create_by!(menu: menu_2, menu_item: beverage_2)
MenuContent.find_or_create_by!(menu: menu_3, menu_item: beverage_4)

# Criação de pedidos
order_1 = Order.find_or_create_by!(restaurant: restaurant_1, customer_name: "João Silva") do |order|
  order.contact_phone = "6731423872"
  order.contact_email = "joao.silva@email.com"
  order.cpf = "945.300.480-47"
end

order_2 = Order.find_or_create_by!(restaurant: restaurant_2, customer_name: "Carlos Oliveira") do |order|
  order.contact_phone = "6731421234"
  order.contact_email = "carlos.oliveira@email.com"
  order.cpf = "305.780.620-11"
  order.status = :in_preparation
end

order_3 = Order.find_or_create_by!(restaurant: restaurant_1, customer_name: "Ana Beatriz") do |order|
  order.contact_phone = "6731425555"
  order.contact_email = "ana.beatriz@email.com"
  order.cpf = "023.009.210-14"
end

# Adicionando itens aos pedidos
OrderItem.find_or_create_by!(order: order_1, serving: Serving.first, note: "Sem cebola")
OrderItem.find_or_create_by!(order: order_2, serving: Serving.last, note: "Bem gelado")
OrderItem.find_or_create_by!(order: order_3, serving: Serving.second, note: "Pouco sal")