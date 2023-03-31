Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :follows, only: %i[create destroy]
      resources :sleep_schedules, only: %i[index create update destroy]
      resources :users, only: %i[index create]
    end
  end
end
