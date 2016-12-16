Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :exams do
    collection do
      get 'search' => 'exams#search'
      get 'search_by_tag' => 'exams#searchByTag'
      get 'take/:id' => 'exams#take'
      get 'find' => 'exams#find_by_user'
      post 'result' => 'exams#result'
      post ':id/update' => 'exams#update'
    end
  end

  get 'users/show' => 'users#show'
  get 'users/latest_history/:exam_id' => 'users#latest_history'

  post 'auth_user' => 'authentication#authenticate_user'
  get 'home' => 'home#index'

  get 'tags/search' => 'tags#search'
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
