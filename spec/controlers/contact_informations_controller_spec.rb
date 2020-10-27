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

  describe 'update_email' do
    let(:user) { FactoryBot.create(:user, with_contact_information: true) }
    let(:new_email) { 'new_email@example.com' }

    it 'should put new email in to field new_email' do
      expect {
        post :update_email, params: { email: new_email }
      }.to change { user.contact_information.reload.new_email }.from(nil).to(new_email)
    end

    it 'should generate code for confirmation new email' do
      post :update_email, params: { email: new_email }
      puts user.contact_information.reload.email_code
      expect(user.contact_information.reload.email_code).to be >= 100000
    end
  end

  describe 'confirm_email' do
    let(:new_email) { 'new_email@example.com' }
    let(:contact_information) { FactoryBot.create(:contact_information,
                                    new_email: new_email,
                                    email_code: ContactInformation.new.send(:generate_code),
                                    user_id: user.id) }
    it 'should update email for user' do
      post :confirm_email, params: { code: contact_information.email_code }
      expect(user.contact_information.email).to eq(new_email)
    end
  end

  describe 'create' do
    it 'should return list of countries' do
      expect do
        post :create, params: contact_information
      end.to change { ContactInformation.count }.from(0).to(1)
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