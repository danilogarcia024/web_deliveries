class UsersController < ApplicationController

  before_filter :require_user_type_1, only: []

  def index
    @users = User.paginate(per_page: 15, page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      redirect_to :users, notice: "El Usuario #{@user.username} fue Registrado"
    else
      render 'new'
    end
  end

  def edit
  end

  def  update
    if current_user.update_attributes(update_user_params)
      redirect_to :root, notice: "Usuario Editado Satisfactoriamente"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :users, notice: 'Usuario Eliminado'
  end

  private
  def create_user_params
    params.require(:user).permit(:name, :email, :username, :admin)
  end

  def update_user_params
    params.require(:user).permit(:name, :email)
  end

  def require_user_type_1
    unless current_user.user_type == 1
      redirect_to :root 
      flash[:error] = "No tiene permisos para realizar esta accion"
    end
  end
end