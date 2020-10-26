require 'rails_helper'

describe Api::V1::RegistrationsController, type: :controller do
  describe 'create' do
    context 'user' do
      context 'with valid params' do
        let(:pas) { 'example_password' }

        let(:user_params) { { email: 'email@example.com',
                              nationality: ISO3166::Country.all_translated('EN').sample,
                              country: ISO3166::Country.all_translated('EN').sample,
                              password: pas,
                              password_confirmation: pas,
                              aml_rules: true,
                              agree_with_terms: true,
                              over_18: true } }

        it "should be created user" do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          expect { post :create, params: { user: user_params }}.to change(User, :count).from(0).to(1)
        end
      end

      context 'with empty params' do
        it "return validation errors" do
          @request.env["devise.mapping"] = Devise.mappings[:user]

          pattern = {
            agree_with_terms: ["is not included in the list"],
            aml_rules: ["is not included in the list"],
            over_18: ["is not included in the list"],
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