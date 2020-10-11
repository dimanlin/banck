Rails.application.routes.draw do
  devise_for :user, controllers: { confirmations: 'confirmations' }

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "resend_invitation", to: "confirmations#create"
      end

      resources :contact_informations, only: [:show, :update, :create]
      resources :countries, only: :index do
        collection do
          get :get_sities
        end
      end
    end
  end
end
