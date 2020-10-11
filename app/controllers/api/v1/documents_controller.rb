class Api::V1::DocumentsController < ActionController::API
  acts_as_token_authentication_handler_for User

  def create

  end

  private

  def document_params
    params.require(:document).permit()
  end
end
