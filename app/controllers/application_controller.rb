class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pagy::Frontend
  include Pundit

  around_action :switch_locale
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def switch_locale(&action)
    # Ensure locale is a string (e.g., "en", "uk")
    locale = (params[:locale] || I18n.default_locale.to_s).to_s
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    return locale if I18n.available_locales.map(&:to_s).include?(locale)
    nil
  end

  def user_not_authorized
    flash[:alert] = "Вам не дозволено виконувати цю дію."
    redirect_to(new_user_session)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
