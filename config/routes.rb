# frozen_string_literal: true

module Twelve
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    post "/telegram/webhook", to: "telegram.webhook"
  end
end
