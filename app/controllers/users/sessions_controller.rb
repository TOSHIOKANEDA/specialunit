# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def edit
    @user = User.find_by(id: params[:format])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    if user.admin = "1"
      users = User.where(admin: "1")
      users.update_all(admin: "0")
      user.update(admin: "1")
      user.save!
    end
    
    redirect_to '/bookings/admin'
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/", alert: "削除しました"
  end
  
  
  
  private
  def user_params
    params.permit(:admin, :email)
  end  
end
