Beauty::Application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'login',  to: 'users/sessions#new',     as: :new_user_session
    get 'logout', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  root to: 'main#index'

  resources :companies
  scope 'employees' do
    match ':id/allow' => 'employees#allow', as: :allow_employee, via: :put
    match ':id/ban'   => 'employees#ban',   as: :ban_employee,   via: :delete
  end
  resources :employees
end
