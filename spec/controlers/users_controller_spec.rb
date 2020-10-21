require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }
  #
  # before do
  #   controller.request.env['X-User-Token'] = user.authentication_token
  # end

  describe 'info' do
    it 'should user' do
      get :info, params: auth
      expect(response.body).to eq('')
    end
  end
end