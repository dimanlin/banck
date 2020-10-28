class Api::V1::ContactInformationsController < ApplicationController
  acts_as_token_authentication_handler_for User

  def create
    ci = ContactInformation.new(create_contact_information_params.merge(user: current_user))

    if ci.save
      render json: ci, status: :ok
    else
      render json: ci.errors.messages, status: :unprocessable_entity
    end
  end

  def confirm_phone_number
    status = if current_user.contact_information.confirm_phone_number(params[:confirmation_code])
               _response_body = {}
               :ok
             else
               _response_body = {code: 'Wrong code.'}
               :unprocessable_entity
             end

    render json: _response_body, status: status
  end

  def update_phone_number
    if current_user.contact_information.update_phone_number(params[:phone_number])
  end

  def show
    response json: current_user.contact_information
  end

  

  private

  def create_contact_information_params
    params.permit(:first_name,
                        :last_name,
                        :phone_number,
                        :dial_code,
                        :dob)
  end

end
