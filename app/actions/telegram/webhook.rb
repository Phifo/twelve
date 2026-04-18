# frozen_string_literal: true

module Twelve
  module Actions
    module Telegram
      class Webhook < Twelve::Action
        def handle(request, response)
          payload = request.params.to_h

          Hanami.logger.info(payload)

          response.status = 200
          response.body = "OK"
        end
      end
    end
  end
end
