class Users::SessionsController < Devise::SessionsController
  def pre_otp
    user = User.find_by pre_otp_params
    @two_factor_enabled = user && user.otp_required_for_login

    respond_to do |format|
      format.js
    end
  end

  private

  def pre_otp_params
    params.require(:user).permit(:email)
  end
end
