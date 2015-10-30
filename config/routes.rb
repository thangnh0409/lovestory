Rails.application.routes.draw do

  get 'photos/index'

  get 'photos/new'

  get 'photos/create'

  get 'photos/destroy'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  #post 'users' => 'users#create'

  resources :users;

  resources :users do
    member do
      get :following, :followers
    end
  end


  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only:[:create, :destroy]

  get 'home' => 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'static_pages#home'


   resources :albums

   resources :photos, only:[:index, :new, :create, :destroy]

end
