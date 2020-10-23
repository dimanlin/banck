class Api::V1::ContactInformationsController < ApplicationController
  acts_as_token_authentication_handler_for User

  def create
    ci = ContactInformation.new(contact_information_params.merge(user: current_user))

    if ci.save
      render json: ci, status: :ok
    else
      render json: ci.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    ci = current_user.contact_information.update(contact_information_params)
    if ci
      render json: ci, status: :ok
    else
      render json: ci.errors.messages, status: :unprocessable_entity
    end
  end

  def show
    response json: current_user.contact_information
  end

  private

  def contact_information_params
    params.permit(:first_name,
                        :last_name,
                        :phone_number,
                        :dial_code,
                        :dob)
  end
end
