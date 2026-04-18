# frozen_string_literal: true

module Twelve
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool
    setting :telegram_bot_token, constructor: Types::String
    setting :telegram_api, constructor: Types::String
  end
end
