Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'd3/*figure', to: 'd3#index'

  root to: 'd3#index'
end
