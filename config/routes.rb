Customers::Application.routes.draw do
  get "dushboard/index"
  get "dushboard",   to: 'dushboard#index'
  devise_for :users

  resources :users, :only => :index
  
  get  'download/:aid(/:forced)', to: 'utility#download'
  get  'download/:aid', to: 'utility#download'
  post 'upload',   to: 'utility#upload'
  delete  'detach/:aid', to: 'utility#detach'

  resources :banks do
    collection do
      get 'branches'
      get 'search'
    end
  end

  resources :branches do
    collection do
      get 'select'
    end
  end

  resources :customers do
    member do
      get 'prev'
      get 'next'
    end
    collection do
      get 'gc'
      get 'password'
      post 'upload'
    end
  end


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
  
  root :to => 'dushboard#index'

end
