Rails.application.routes.draw do
    resources :users do
      resources :salaries, only: [:index, :create, :update, :destroy]
      resources :salary_histories, only: [:index, :create, :update, :destroy]
    end
    resources :taxes, only: [:index, :create, :update, :destroy]
end
  
