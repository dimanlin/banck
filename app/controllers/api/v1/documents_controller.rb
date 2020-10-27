class Api::V1::DocumentsController < ActionController::API
  acts_as_token_authentication_handler_for User

  def create
    document = Document.new(document_params.merge(user_id: current_user.id))

    if document.save
      render json: document
    else
      render json: document.errors.messages, status: :unprocessable_entity
    end
  end

  def document_types
    render json: Document.document_types
  end

  private

  def document_params
    params.permit(:country, :document_type,
                  :issued_at, :number, :expired_at)
  end
end
