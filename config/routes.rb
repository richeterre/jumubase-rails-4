Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :contests, only: [:index] do
        resources :performances, only: :index # nested to allow filtering by contest
      end
      resources :performances, only: :create
    end
  end

  resources :contests do
    resources :performances, only: [:index, :show], shallow: true # only nests collection actions
  end

  root 'pages#home'
end
