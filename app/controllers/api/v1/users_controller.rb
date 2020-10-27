class Api::V1::UsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  def show; end

  def info; end

  def update_email
    current_user.update_email(params[:email])
    render json: {}
  end

  def confirm_email
    if current_user.confirm_email(params[:code])
      render json: {}
    else
      render json: {}, status: :unprocessable_entity
    end
  end

end
