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

  resources :proponents do
    get 'calculate_discount', on: :collection
  end
  resources :salaries

  # Address
  resources :countries
  resources :states
  resources :cities

  root to: 'users#index'
end
