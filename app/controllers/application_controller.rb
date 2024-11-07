class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pagy::Frontend
  include Pundit  # Додаємо Pundit в контролери

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Вам не дозволено виконувати цю дію."
    redirect_to(new_user_session)
  end
end
