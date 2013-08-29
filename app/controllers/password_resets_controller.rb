class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    user.send_password_reset if user
    flash[:success] = "Email sent with password reset instructions."
    redirect_to root_url
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired."
      redirect_to forgot_path
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password has been reset."
      redirect_to root_url
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
