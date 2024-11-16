class Employees::RegistrationsController < Devise::RegistrationsController
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.find_by(email: sign_up_params[:email])

    unless @employee
      @employee = Employee.new(sign_up_params)  
      flash[:alert] =
       'Email ou CPF inválidos ou não foram pré-cadastrados. Verifique com a administração do Restaurante'
      return render :new
    end

    if @employee.update(sign_up_params)
      @employee.active!
      sign_in(@employee)
      redirect_to root_path, notice: 'Cadastro concluído com sucesso.'
    else
      flash[:alert] = 'Erro ao atualizar os dados. Verifique as informações e tente novamente.'
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:employee).permit(:email, :cpf, :password, :password_confirmation, :name)
  end
end
