# frozen_string_literal: true

Rails.application.routes.draw do
  mount ApiAuthentication::Engine => '/api'
end
