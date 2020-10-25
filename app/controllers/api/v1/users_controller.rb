class Api::V1::UsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  def show; end

  def info; end

  def confirm_phone_number
    status = if current_user.confirm_phone_number(params[:confirmation_code])
               _response_body = {}
               :ok
             else
               _response_body = {code: 'Wrong code.'}
               :unprocessable_entity
             end

    render json: _response_body, status: status
  end

end
