require 'rails_helper'

describe Api::V1::DocumentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:contact_information) { FactoryBot.attributes_for(:contact_information) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }

  before do
    user.confirm
    request.headers["X-User-Token"] = user.authentication_token
    request.headers["X-User-Email"] = user.email
  end

  describe 'documen_types' do
    it 'should return available document types' do
      pattern = {
          'Passport' => 0,
          'Driving license' => 1,
          'ID' => 2
      }
      get :document_types

      expect(response.body).to match_json_expression(pattern)
    end
  end
end
