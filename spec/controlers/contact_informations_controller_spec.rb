require 'rails_helper'

describe Api::V1::ContactInformationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:contact_information) { FactoryBot.attributes_for(:contact_information) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }

  describe 'create' do
    it 'should return list of countries' do
      expect do
        post :create, params: { contact_information: contact_information }.merge(auth)
      end.to change { ContactInformation.count }.from(0).to(1)
    end
  end
end