Rails.application.routes.draw do
  resources :posts
  root :to => "employee#index"
  get "login" => "session#login_form"
  post "login" => "session#login"
  post "logout" => "session#logout"
  get "employee/index" => "employee#index"
  get "employee/new" => "employee#new"
  post "employee/create" => "employee#create"
  get "employee/:id/edit" => "employee#edit"
  patch "employee/:id/update" => "employee#update"
  delete "employee/:id/destroy" => "employee#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
