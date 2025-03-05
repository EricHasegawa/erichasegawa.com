class RegistrationsController < ApplicationController
    allow_unauthenticated_access
    def new
      @user = User.new
    end
    def create
      flash[:alert] = "Sign-ups are currently disabled."
      redirect_to new_registration_path, status: :forbidden
    end
    private
    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end
