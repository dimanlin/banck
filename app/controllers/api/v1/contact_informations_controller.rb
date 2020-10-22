class Api::V1::ContactInformationsController < ApplicationController
  acts_as_token_authentication_handler_for User

  def create
    ci = current_user.contact_information.create(contact_information_params)
    response json: ci, status: :ok
  end

  def update
    ci = current_user.contact_information.update(contact_information_params)
    if ci
      response json: ci, status: :ok
    else
      response json: ci.errors.messages, status: :unprocessable_entity
    end
  end

  def show
    response json: current_user.contact_information
  end

  private

  def contact_information_params
    params.require(:contact_information).permit(:first_name,
                                                :last_name,
                                                :phone_number,
                                                :dob)
  end
end
