# frozen_string_literal: true

ApiAuthentication::Engine.routes.draw do
  resource :push_tokens, only: %i[create destroy] if ApiAuthentication.configuration.push_tokens
  resource :registrations, only: :create if ApiAuthentication.configuration.registrations

  if ApiAuthentication.configuration.sessions
    resource :sessions,
             only: ApiAuthentication.configuration.refresh_tokens ? %i[create destroy] : :create
  end

  resource :access_tokens, only: :create if ApiAuthentication.configuration.refresh_tokens

  if ApiAuthentication.configuration.facebook_login
    namespace :facebook do
      resource :sessions, only: :create
    end
  end
end
