Rails.application.routes.draw do
  get "home/index"

  # para usuários e não libera o cadastro próprio do devise
  devise_for :users, skip: [:registrations]

  scope '/admin' do
    resources :users, only: [:index, :new, :edit, :show, :create, :destroy] do
      member do
        patch :inativar_usuario, :ativar_usuario
      end
    end
  end


  resources :polls, except: [:edit] do
    member do
      patch :close
    end
    collection do
      get :meus_votos
    end
    resources :options, only: [:create]
    resources :votes, only: [:create]
  end

  resources :votes, only: [:index]

  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end
  

  unauthenticated do
    root to: redirect("/users/sign_in"), as: :unauthenticated_root
  end

  root to: "home#index"
  get 'my_polls', to: 'polls#my_polls', as: :my_polls

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
