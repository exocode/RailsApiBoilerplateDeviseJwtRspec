Rails.application.routes.draw do
  get 'welcome/home'
  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
             path: 'auth',
             defaults: { format: :json },
             controllers: {
               sessions: 'auth/sessions',
               registrations: 'auth/registrations',
               passwords: 'auth/passwords',
               confirmations: 'auth/confirmations'
             }

  # authenticate :user, ->(u) { u || u.is_admin? } do
  require 'sidekiq/web'
  require 'sidekiq/api'

  mount Sidekiq::Web => '/sidekiq-interface'

  get 'sidekiq-queue-size' => proc { [200, { 'Content-Type' => 'text/plain' }, [Sidekiq::Queue.new.size.to_s]] }
  get 'sidekiq-queue-latency' => proc { [200, { 'Content-Type' => 'text/plain' }, [Sidekiq::Queue.new.latency.to_s]] }
  # end
  #
  root to: 'welcome#home'
  get 'check', to: 'welcome#check'
end
