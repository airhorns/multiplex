Multiplex::Application.routes.draw do

  devise_for :users,
    :skip => [:passwords, :registrations],
    :controllers => { :registrations => "registrations" } do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
    get "sign_up", :to => "registrations#new"
    post "user_registration", :to => "registrations#create"
    get "new_user_registration", :to => "registrations#new"
  end

  resources :messages, :only => [] do
    post 'sendgrid_create', :on => :collection
    post 'cloudmailin_create', :on => :collection
    get 'deliver', :on => :member
  end
    
  resources :delivery_manifests, :only => [:update] do
    get 'update', :on => :member
  end 

  match 'faq' => 'dashboard#faq', :as => :faq
  match 'help' => 'dashboard#help', :as => :help
  match 'send_summary' => 'dashboard#send_summary', :as => :send_summary
  root :to => "dashboard#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
