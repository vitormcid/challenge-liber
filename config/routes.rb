Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get 'welcome/index'
  root 'welcome#index'  

  resources :person
  resources :locations
  resources :drivers_licenses
  resources :phones
  resources :report
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

