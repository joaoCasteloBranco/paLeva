class  MenuContentsController < ApplicationController
  before_action :set_restaurant_menu
  before_action :authenticate_user!

  def new
    @menu_content = MenuContent.new
  end

  def create

    @menu_content = @menu.menu_contents.build(menu_content_params)

    if @menu_content.save
      redirect_to new_restaurant_menu_menu_content_path(
        @restaurant, @menu
      ), notice: "Cadastrado com sucesso"
    else
      flash.now[:alert] = "Não foi possível realizar o cadastro"
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    @menu_content = MenuContent.find(params[:id])
    if @menu_content.destroy
      @menu.reload
      puts @menu_content.errors.full_messages
      redirect_to restaurant_menu_path(@restaurant, @menu), notice: 'Prato excluído com sucesso do cardápio!'
    else
      flash[:alert] = "Erro ao excluir o prato do cardápio"
      redirect_to restaurant_menu_path(@restaurant, @menu)
    end
  end

  private

  def set_restaurant_menu
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.find(params[:menu_id])
  end

  def menu_content_params
    params.
    require(:menu_content)
    .permit(
      :menu_item_id
    )
  end

end