require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { FactoryBot.create(:user) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }
  
  before do
    user.confirm
    request.headers["X-User-Token"] = user.authentication_token
    request.headers["X-User-Email"] = user.email
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

  describe 'confirm_phone_number' do
    let(:user) { FactoryBot.create(:user) }

    it 'should return status :ok' do
      phone_number_code = user.contact_information.phone_code

      post :confirm_phone_number, params: { confirmation_code: phone_number_code }
      expect(response).to be_ok
    end

    it 'should return status :unprocessable_entity' do
      phone_number_code = '9283749' # Wrong number

      post :confirm_phone_number, params: { confirmation_code: phone_number_code }
      expect(response.status).to eq(422)
    end

  end
end