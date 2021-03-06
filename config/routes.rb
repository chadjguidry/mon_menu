MonMenu::Application.routes.draw do
  devise_for :users, :controllers => { :passwords => "passwords" }
  
  # These routes must come before resoures :foods, or images won't be shown
  get 'foods/show_food_photo' => "foods#show_food_photo"
  get 'foods/show_food_thumb' => "foods#show_food_thumb"
  get 'foods/show_homepage_thumb' => "foods#show_homepage_thumb"
  get 'foods/main_dishes' => "foods#main_dishes"
  get 'foods/side_dishes' => "foods#side_dishes"
  get 'foods/snacks' => "foods#snacks"

  get 'contact' => 'contact_forms#new'
  get 'contact_forms' => 'contact_forms#new'


  resources :foods do
    resources :photos
  end

  resources :contact_forms, only: [:new, :create]

  root "static_pages#home"
  get 'about' => 'static_pages#about'
  
  get 'privacy' => 'static_pages#privacy'
  get 'terms_of_service' => 'static_pages#terms_of_service'
  get 'demo' => 'static_pages#demo'

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
