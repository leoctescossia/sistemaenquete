class HomeController < ApplicationController
  def index
  end

  def require_admin
    redirect_to root_path, alert: "Acesso negado." unless current_user&.admin?
  end
end
