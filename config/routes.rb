Rails.application.routes.draw do
  get "house_expenses/account_cycle_summary" => "house_expenses#account_cycle_summary", :as => 'account_cycle_summary'
  resources :house_settings
  resources :house_account_cycles
  get 'sessions/new'

  resources :house_expense_per_tenants
  resources :house_expenses
  resources :house_expense_templates
  resources :recurring_frequencies
  resources :tenants
  resources :houses
  resources :sessions
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "house_expenses/update_fixed_expense/:fixed_expense_id" => "house_expenses#update_fixed_expense", :as => 'update_fixed_expense'
  get "house_expenses/edit_division_factor/:house_expense_id" => "house_expenses#edit_division_factor", :as => 'edit_division_factor'
  post "house_expenses/update_division_factor/:house_expense_id" => "house_expenses#update_division_factor", :as => 'update_division_factor'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'houses#index'

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
