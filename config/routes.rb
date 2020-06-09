# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  post 'oauth/token', to: 'api/oauths#token'
end
