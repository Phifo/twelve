# frozen_string_literal: true

module Twelve
  module Actions
    module Telegram
      class Webhook < Twelve::Action
        def handle(request, response)
          payload = request.params.to_h

          app["logger"].info(payload)

          res.status = 200
          res.body = "OK"
        end
      end
    end
  end
end
