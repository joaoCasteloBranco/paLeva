class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @employees = @restaurant.employees
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @employee = Employee.new
  end

  def create
    @employee = @restaurant.employees.build(employee_params)
    @employee.status = :pre_registered
    
    if @employee.save
      redirect_to restaurant_path(@restaurant), notice: 'Funcionário pré-cadastrado com sucesso.'
    else
      puts @employee.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def employee_params
    params.require(:employee).permit(:email, :cpf)
  end
  
end