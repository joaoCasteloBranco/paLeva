class  OperatingDaysController < ApplicationController
  before_action :set_restaurant
  before_action :authorize_operating_day!, only: [:show, :new, :edit]

  def show
    @operating_day = OperatingDay.find(params[:id])
  end

  def new
    @operating_day = OperatingDay.new
  end

  def create
    if @restaurant.operating_days.create(operating_day_params)
      redirect_to @restaurant, notice: 'Horário Adicionado'
    else
      redirect_to @restaurant, alert: 'Falha ao adicionar o horário'
    end
  end

  def edit
    @operating_day = OperatingDay.find(params[:id])
  end

  def update
    if @restaurant.operating_days.update(operating_day_params)
      redirect_to @restaurant, notice: 'Horário Atualizado'
    else
      redirect_to @restaurant, alert: 'Falha ao atualizar o horário'
    end

  end

  private 

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def operating_day_params
    params
    .require(:operating_day)
    .permit(
      :week_day,
      :open,
      :opening_time,
      :closing_time
    )
  end

  def authorize_operating_day!
    unless @restaurant.user_id == current_user.id
      redirect_to root_path, alert: 'Acesso negado!'
    end
  end

end 