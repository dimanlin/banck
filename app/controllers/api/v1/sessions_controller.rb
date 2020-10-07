class Api::V1::SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    yield resource if block_given?
    respond_with resource.attributes.slice('authentication_token').to_json, location: after_sign_in_path_for(resource)
  end
end