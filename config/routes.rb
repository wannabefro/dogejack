Dogejack::Application.routes.draw do
  devise_for :users, path_prefix: 'api', controllers: { sessions: 'sessions', registrations: 'registrations' }
  namespace :api do
    devise_scope :user do
      post "registrations" => "registrations#create"
      post "sign_in" => "sessions#create"
      post "sign_out" => "sessions#destroy"
    end
    resources :games, only: [:create]
    get "games/deal" => "games#deal"
    get "games/hit" => "games#hit"
    get "games/stand" => "games#stand"
    get "games/dealer" => "games#dealer"
    get "games/double" => "games#double"
    get "games/split" => "games#split"
    get "games/surrender" => "games#surrender"
  end

  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
