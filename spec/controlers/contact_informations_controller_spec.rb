require 'rails_helper'

describe Api::V1::ContactInformationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:contact_information) { FactoryBot.attributes_for(:contact_information) }
  let(:auth) { { user_email: user.email, user_token: user.authentication_token } }

  describe 'create' do
    it 'should return list of countries' do
      # request.headers.merge! 'X-User-Email' => user.email
      # request.headers.merge! 'X-User-Token' => user.authentication_token

      expect do
        post :create, params: { contact_information: contact_information }.merge(auth)
      end.to change { ContactInformation.count }.from(0).to(1)
    end
  end

  # describe 'show' do
  #   it 'should return list of cities for US' do
  #
  #   end
  # end
end