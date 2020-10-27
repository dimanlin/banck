class Api::V1::UsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  def show; end

  def info; end

end
