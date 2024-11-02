class  OperatingDaysController < ApplicationController

  def show
    @operating_day = OperatingDay.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @operating_day = OperatingDay.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    
    operating_day_params = params
    .require(:operating_day)
    .permit(
      :week_day,
      :open,
      :opening_time,
      :closing_time
    )

    if @restaurant.operating_days.create(operating_day_params)
      redirect_to @restaurant, notice: 'Horário Adicionado'
    else
      redirect_to @restaurant, alert: 'Falha ao adicionar o horário'
    end
  end

  def edit
    @operating_day = OperatingDay.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    
    operating_day_params = params
    .require(:operating_day)
    .permit(
      :week_day,
      :open,
      :opening_time,
      :closing_time
    )

    if @restaurant.operating_days.update(operating_day_params)
      redirect_to @restaurant, notice: 'Horário Atualizado'
    else
      redirect_to @restaurant, alert: 'Falha ao atualizar o horário'
    end

  end

end 