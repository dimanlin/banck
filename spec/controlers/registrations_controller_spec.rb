require 'rails_helper'

describe Api::V1::RegistrationsController, type: :controller do
  describe 'create' do
    context 'user' do
      context 'with valid params' do
        let(:pas) { 'example_password' }
        let(:passwords) { { password: pas, password_confirmation: pas } }
        let(:user_params) { FactoryBot.attributes_for(:user).merge(passwords) }

        it "should be created user" do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          expect { post :create, params: { user: user_params }}.to change(User, :count).from(0).to(1)
        end
      end

      context 'with empty params' do
        it "return validation errors" do
          @request.env["devise.mapping"] = Devise.mappings[:user]

          pattern = {
            email: ["can't be blank"],
            password: ["can't be blank"],
            nationality: ["can't be blank", "is not included in the list"],
            country: ["can't be blank","is not included in the list"]
          }

          expect { post :create, params: { user: {} }}.to change(User, :count).by(0)
          expect(response.body).to match_json_expression(pattern)
        end
      end
    end
  end
end