Rails.application.routes.draw do
  devise_for :user, controllers: { confirmations: 'api/v1/confirmations' }

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "resend_invitation", to: "confirmations#create"
        get "confirmation", to: "confirmations#show1"
      end

      resources :contact_informations, only: [:show, :create] do
        collection do
          post :confirm_phone_number
        end
      end
      resources :documents, only: :create do
        collection do
          get :document_types
        end
      end

      resources :users do
        collection do
          get :info
          post :update_email
          post :confirm_email
        end
      end

      resources :countries, only: :index do
        collection do
          get :get_sities
        end
      end
    end
  end
end
