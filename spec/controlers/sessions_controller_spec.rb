require 'rails_helper'

describe Api::V1::SessionsController, type: :controller do
  describe 'create session' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'success' do
      let(:passwords) { { password: 'root0000', password_confirmation: 'root0000' } }
      let(:user) { FactoryBot.create(:user, passwords) }
      it 'return token' do
        pattern = { email: user.email,
                    authentication_token: user.authentication_token }

        post :create, params: { user: { email: user.email }.merge(passwords) }, format: :json
        expect(response.body).to match_json_expression(pattern)
      end
    end

    context 'invalid' do
      let(:user_params) { { email: 'fake@email.com', password: 'root0000' } }
      it 'return token' do
        pattern = { error: "Invalid Email or password." }
        post :create, params: { user: user_params }, format: :json
        expect(response.body).to match_json_expression(pattern)
      end
    end
  end
end