Rails.application.routes.draw do
  devise_for(
    :users,
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'signup',
      sessions: 'sessions'
    },
    controllers: { sessions: 'users/sessions' }
  )

  resources :users

  get 'addresses/search', controller: 'addresses/search', action: :index

  resources :proponents do
    collection do
      get 'calculate_discount', controller: 'proponents/calculate_discounts', action: :index
      get 'reports', controller: 'proponents/reports', action: :index
    end
  end

  resources :salaries

  # Address
  resources :countries
  resources :states
  resources :cities

  root to: 'users#index'
end
