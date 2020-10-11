class Api::V1::SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json

  USER_SESSION_FIELDS = ['id', 'aml_rules', 'nationality', 'email', 'authentication_token', 'country'].freeze

  def create
    self.resource = warden.authenticate!(auth_options)
    yield resource if block_given?
    respond_with session_response(resource).to_json, location: after_sign_in_path_for(resource)
  end

  private

  def session_response(user)
    resp = user.attributes.slice(*USER_SESSION_FIELDS)
    resp.merge!(enough_contact_information: true) if user.contact_information.nil?
    resp.merge!(enough_document: true) if user.document.nil?
    resp
  end
end