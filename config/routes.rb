Rails.application.routes.draw do
  resources :users

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

  # Access
  resources :access_permissions do
    resources :access_levels, only: %i[create destroy], controller: 'access_permissions/access_levels'
  end
  resources :access_levels

  resources :proponents do
    collection do
      get 'calculate_discount', controller: 'proponents/calculate_discounts', action: :index
      get 'reports', controller: 'proponents/reports', action: :index
    end
  end

  resources :salaries

  # Address
  get 'addresses/search', controller: 'addresses/search', action: :index
  resources :countries
  resources :states
  resources :cities

  root to: 'users#index'
end
