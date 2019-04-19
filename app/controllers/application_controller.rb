# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  protect_from_forgery with: :exception

  def set_user
    @user = User.find_by(uuid: cookies.encrypted[:uuid])
  end
end
