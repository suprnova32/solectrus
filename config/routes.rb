Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
  mount Lockup::Engine, at: '/lockup' if Rails.env.production?

  constraints field: Regexp.new(Senec::FIELDS_COMBINED.join('|'), false),
              timeframe: Timeframe.regex do
    get '/(/:field)(/:timeframe)', to: 'home#index', as: :root
    get '/stats/:field(/:timeframe)', to: 'stats#index', as: :stats
    get '/charts/:field(/:timeframe)', to: 'charts#index', as: :charts

    # Redirect old routes
    get '/:period/:field/(:timestamp)', to: redirect('/%{field}')
  end

  constraints period: /day|month|year/,
              field: Regexp.new(Senec::POWER_FIELDS.join('|'), false) do
    get '/top10/:period/:field', to: 'top10#index', as: :top10
    get '/top10-chart/:period/:field', to: 'top10_chart#index', as: :top10_chart
  end

  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create', as: :sessions
  delete '/logout', to: 'sessions#destroy', as: :session

  scope :settings do
    resources :prices
  end
end
