class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to user_omniauth_authorize_path(:facebook)
  end

  def create
    super
  end

  def destroy
    super
  end
end
