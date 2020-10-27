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
    context 'success' do
      it 'should return list of countries' do
        expect do
          post :create, params: contact_information
        end.to change { ContactInformation.count }.from(0).to(1)
      end
    end

    context 'invalid' do
      it 'should return list of countries' do
        pattern = {
            first_name: ["can't be blank"],
            last_name: ["can't be blank"],
            phone_number: ["can't be blank"],
            dial_code: ["can't be blank"],
            dob: ["can't be blank"]
        }

        post :create, params: {}
        expect(response.body).to match_json_expression(pattern)
        expect(response.code).to eq('422')
      end
    end
  end


  describe 'confirm_phone_number' do
    let(:user) { FactoryBot.create(:user, with_contact_information: true) }

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