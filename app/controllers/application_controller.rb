class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :admin_signed_in?

  def admin_signed_in?
    user_signed_in? && current_user.role === "admin"
  end
end
