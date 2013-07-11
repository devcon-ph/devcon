class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    omniauth = request.env["omniauth.auth"]
    user = User.from_omniauth(omniauth)

    unless user.nil?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
      sign_in_and_redirect user
    else
      flash[:alert] = "Registrations are not open yet, but please check back soon"
      redirect_to root_path
    end
end

  # todo add other provider
  alias_method :facebook, :all
end
