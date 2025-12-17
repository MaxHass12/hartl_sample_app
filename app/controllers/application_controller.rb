class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user, :logged_in?
end
