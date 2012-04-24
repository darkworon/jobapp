Jobapp::Application.routes.draw do
  #scope '(:locale)' do
    match "catalog/vacancies" => "catalog#vacancies"
    match "catalog/resumes" => "catalog#resumes"
    match "catalog/companies" => "catalog#companies"
    resources :vacancies
    resources :resumes
    resources :companies
    controller :users do
      get 'user/profile' => :profile
      match 'user/profile' => :update_profile, as: :update_profile
      match 'user/profile/:id' => :show, as: :show_user_profile
      get 'register' => :new
      match 'register' => :create
      get 'user/subscriptions' => :subscriptions
    end
    get "order/pay" => "payments#index", as: :pay_order
    resources :orders
    match "vacancy/priority" => "vacancies#priority", as: :vacancy_priority
    post "vacancy/:id/publish" => "vacancies#publish", as: :publish_vacancy
    post "vacancy/:id/hide" => "vacancies#hide", as: :hide_vacancy
    post "vacancy/:id/ban" => "vacancies#ban", as: :ban_vacancy
    match "vacancy/salary" => "vacancies#salary", as: :vacancy_salary
    match "resume/salary" => "resumes#salary", as: :resume_salary
    match "vacancy/salary_get" => "vacancies#get_data", as: :get_vac_salary
    match "professions/list/resumes" => "search#professions_resumes", as: :professions_resume_list
    match "professions/list/vacancies" => "search#professions_vacancies", as: :professions_vacancy_list
    match "resume/priority" => "resumes#priority", as: :resume_priority
    post "resume/:id/publish" => "resumes#publish", as: :publish_resume
    post "resume/:id/hide" => "resumes#hide", as: :hide_resume
    #resources :user_expences
    
    #resources :user_subscriptions

    #resources :banking_details
    #get 'hello' => 'application#hello_world'
    get 'pricelists/drafts' => "pricelists#drafts", as: :price_list_drafts
    get 'pricelists/archived' => "pricelists#archived", as: :archived_price_lists
    post 'pricelist/:id/activate' => "pricelists#activate", as: :activate_pricelist
    resources :pricelists
    controller :password do
      match "password/recover" => :recover, as: :recover_password
      match "password/recover/:recover_link" => :index, as: :password_change
    end
    match 'home/index' => "home#index"
    get 'admin' => 'admin#index'
    get "responses" => 'responses#index'
    get "responses/recieved" => 'responses#recieved'
    get "responses/sended" => 'responses#sended'
    get "status/check" => 'status#check'
    controller :sessions do
        get  'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
        get 'logout' => :destroy
    end
    controller :favorites do
        match 'favorite/resumes' => :resumes, as: :favorite_resumes
        match 'favorite/vacancies' => :vacancies, as: :favorite_vacancies
        match 'favorites/add/:id' => :add, as: :add_favorite
        get 'favorites/remove/:id' => :remove, as: :remove_favorite
    end
    controller :vacancy_responses do
      post 'response/vacancy/:id' => :create, as: :create_vacancy_response
      get 'response/vacancy/:id' => :new, as: :vacancy_response
      get 'responses/vacancy' => :index, as: :vacancy_responses
      post 'response/view/:id/ok' => :ok, as: :ok_vacancy_response
      get 'response/accept/:id' => :accept, as: :accept_vacancy_response
      get 'response/decline/:id' => :decline, as: :decline_vacancy_response
    end
    
    controller :resume_responses do
      post 'response/resume/:id' => :create, as: :create_resume_response
      get 'response/resume/:id' => :new, as: :resume_response
      get 'responses/resume' => :index, as: :resume_responses
      post 'resume/response/:id/ok' => :ok, as: :ok_resume_response
      get 'resume/response/accept/:id' => :accept, as: :accept_resume_response
      get 'resume/response/decline/:id' => :decline, as: :decline_resume_response
    end
    match "user/activation/resend" => "activations#resend", as: :resend_activation, method: :get
    match "user/activate/:act_link" => "activations#index", as: :activation, method: :get
    match "resume/new/based/on/:id" => "resumes#new", :as => :new_resume_based_on, method: :get
    match "resume/new/based/on/:id" => "resumes#create", :as => :new_resume_based_on, method: :post
    match "vacancies/new/based/on/:id" => "vacancies#new", :as => :new_vacancy_based_on, method: :get
    match "vacancies/new/based/on/:id" => "vacancies#create", :as => :new_vacancy_based_on, method: :post
    
    #controller :resumes do
    #    get 'resumes' => :index
    #    match 'resumes/show/:id' => :show, as: :resume
    #    get 'resume/new/based/on(/:id)' => :new, :as => :new_resume_based_on
    #    post 'resume/new/based/on(/:id)' => :create, :as => :new_resume_based_on
    #    get 'resumes/edit(/:id)' => :edit
    #    post 'resumes/edit(/:id)' => :update
    #end
    #
    #post "vacancies/new" => "vacancies#create", as: :create_vacancy

    get "moderator" => 'moderator#index'
    scope 'moderator' do
      match 'vacancies' => "moderator#vacancies", as: :moderator_vacancies
      match 'resumes' => "moderator#resumes", as: :moderator_resumes
      match 'users' => "moderator#users", as: :moderator_users
      controller :users do
        match 'user/:id/edit' => :edit, as: :edit_user, method: :get
        match 'user/:id/update' => :update, as: :update_user
      end
    end
    
    #resources :jobs
    #resources :users
    
    root to: 'search#vacancy', as: 'home'
    get "search/resume" => "search#resume"
    get "search/vacancy" => "search#vacancy"
    #get 'home' => 'home#index'
    get 'about' => 'home#about'
    #match "search/resume(/:search(/:page))" => 'search#resume', :as => :search_res
    #match "search/vacancy(/:search(/:page))" => 'search#vacancy', :as => :search_vac
  #end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
