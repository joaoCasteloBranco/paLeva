class  OperatingDaysController < ApplicationController
  before_action :set_restaurant
  before_action :set_operating_day, only: [:show, :edit, :update]
  before_action :authorize_operating_day!, only: [:show, :new, :edit]

  def show; end

  def new
    @operating_day = OperatingDay.new
  end

  def create
    @operating_day = @restaurant.operating_days.new(operating_day_params)

    if @operating_day.save
      redirect_to @restaurant, notice: 'Horário Adicionado'
    else
      flash.now[:alert] = 'Falha ao adicionar o horário'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @operating_day.update(operating_day_params)
      redirect_to @restaurant, notice: 'Horário Atualizado'
    else
      redirect_to @restaurant, alert: 'Falha ao atualizar o horário'
    end
  end

  private 

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_operating_day
    @operating_day = OperatingDay.find(params[:id])
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