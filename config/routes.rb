# frozen_string_literal: true

Rails.application.routes.draw do
  root 'clients#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :clients, only: %i[index show edit update]
end
