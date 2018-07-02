class ProfileUserController < ApplicationController
  layout "profile_user"
  before_action :set_user, only: [:index, :show, :edit, :update, :pets, :duties, :feed, :friends]

  def index
    @user = ProfileUser.find_or_create_by(user_id: params[:id])
  end

  def show
  end
  
  def edit
  end

  def update
    if @user.update(params_user)
      redirect_to profile_user_path(current_user.id) , notice: "Dados atualizados com sucesso."
    else
      render :edit
    end
  end

  def pets
    @pets = @user.pets
  end

  def duties
    params["field_order"] ||= 'until'
    @duties = @user.duties.order("#{params["field_order"]} DESC")
  end

  def feed
    @duties = @user.duties
  end

  def friends
    @friends = @user.profile_users.where.not(id: current_user.id).distinct
  end

  private

  def set_user
  	@user = ProfileUser.find(current_user.id)
  end

  def params_user
  	params.require(:profile_user).permit(:first_name, :last_name, :birthday, :address, :phone, :picture)
  end

end
