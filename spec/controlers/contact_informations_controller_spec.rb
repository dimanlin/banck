require 'rails_helper'

describe Api::V1::ContactInformationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:contact_information) { FactoryBot.attributes_for(:contact_information) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }

  before do
    user.confirm
    request.headers["X-User-Token"] = user.authentication_token
    request.headers["X-User-Email"] = user.email
  end

  describe 'create' do
    it 'should return list of countries' do
      expect do
        post :create, params: contact_information
      end.to change { ContactInformation.count }.from(0).to(1)
    end
  end
end