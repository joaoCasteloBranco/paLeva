class Employees::RegistrationsController < Devise::RegistrationsController
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.find_by(email: sign_up_params[:email])
    
    if @employee && @employee.update(sign_up_params)
      @employee.active!
      sign_in(@employee)
      redirect_to root_path, notice: 'Cadastro concluído com sucesso.'
    else
      puts @employee.errors.full_messages
      flash[:alert] = 'Email ou CPF inválidos ou não encontrados.'
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:employee).permit(:email, :cpf, :password, :password_confirmation, :name)
  end
end
