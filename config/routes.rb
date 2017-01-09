Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :questions, only: [:index, :create, :show, :edit, :update, :destroy] do
        scope module: :questions do
          resources :related_questions, only: [:index]
        end
      end
      resources :answers, only: [:create, :edit, :destroy, :update]
      resources :comments, only: [:create, :show, :edit, :update, :destroy]
      resources :votes, only: [:create, :destroy, :update]
      resources :tags, only: [:index]
      resources :views, only: [:create]
      resources :flags, only: [:create]
      resources :images, only: [:create]
      resources :users, only: [:index, :show, :create]

      post '/authenticate' => 'auth#authenticate'
      # reset password
      post '/passwords' => 'passwords#create'
      put  '/passwords' => 'passwords#update'
    end
  end

  get '/auth/failure', to: 'auth#failure'
  match '/auth/:provider/callback', to: 'auth#callback', via: [:get, :post]
end
