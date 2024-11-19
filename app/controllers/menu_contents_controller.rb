class  MenuContentsController < ApplicationController
  before_action :set_restaurant_menu

  def new
    @menu_content = MenuContent.new
  end

  def create

    menu_content_params = params.
    require(:menu_content)
    .permit(
      :menu_item_id
    )

    @menu_content = @menu.menu_contents.build(menu_content_params)

    if @menu_content.save
      redirect_to new_restaurant_menu_menu_content_path(
        @restaurant, @menu
      ), notice: "Cadastrado com sucesso"
    else
      flash.now[:alert] = "Não foi possível realizar o cadastro"
      render :new
    end

  end

  def destroy
    @menu_content = MenuContent.find(params[:id])
    @menu_content.destroy
    redirect_to restaurant_menu_path(@restaurant, @menu), notice: 'Prato excluído com sucesso do cardápio!'
  end

  private

  def set_restaurant_menu
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.find(params[:menu_id])
  end

end