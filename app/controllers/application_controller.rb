class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include LtiProvider::LtiApplication
  include CanvasOauth::CanvasApplication
end
