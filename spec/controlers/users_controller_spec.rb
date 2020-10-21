require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { FactoryBot.create(:user) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }
  
  before do
    user.confirm
    request.headers["X-User-Token"] = user.authentication_token
    request.headers["X-User-Email"] = user.email
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'info' do
    it 'should user' do
      pattern = {
          aml_rules: user.aml_rules,
          nationality: user.nationality,
          email: user.email,
          authentication_token: String,
          country: user.country
      }
      get :info
      expect(response.body).to match_json_expression(pattern)
    end
  end
end