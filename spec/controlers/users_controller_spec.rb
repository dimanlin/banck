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


  describe 'update_email' do
    let(:new_email) { 'new_email@example.com' }
    let(:user) { FactoryBot.create(:user, with_contact_information: true) }

    it 'should generate code for confirmation new email' do
      expect(SmsClient).to receive(:send_sms)
      post :update_email, params: { email: new_email }
      expect(user.reload.email_code).to be >= 100000
      expect(user.reload.email).to eq(user.email)
    end
  end

  describe 'confirm_email' do
    let(:new_email) { 'new_email@example.com' }

    context 'success' do
      let(:user) { FactoryBot.create(:user,
                                     email_code: ContactInformation.new.send(:generate_code)) }


      before do
        user.confirm
        request.headers["X-User-Token"] = user.authentication_token
        request.headers["X-User-Email"] = user.email
      end


      it 'should update email for user' do
        user.update(email: new_email)
        post :confirm_email, params: { code: user.email_code }
        expect(user.reload.email).to eq(new_email)
      end
    end

    context 'confirmation code wrong' do
      it 'should return status unprocessable_entity' do
        user.update(email: new_email)
        post :confirm_email, params: { code: 'wrong_code' }
        expect(response.code).to eq('422')
        expect(user.reload.email).to_not eq(new_email)
      end
    end
  end

end