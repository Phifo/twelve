# frozen_string_literal: true

module Twelve
  module Actions
    module Telegram
      class Webhook < Twelve::Action
        include Deps["settings"]

        def handle(request, response)
          response.format = :json

          message = request.params[:message]

          unless message
            response.status = 200
            response.body = { ok: true, ignored: "no_message" }.to_json
            return
          end

          chat_id = message.dig(:chat, :id)
          text = message[:text].to_s.strip

          send_message(chat_id, text)

          response.status = 200
          response.body = "OK"
        end

        private

        def send_message(chat_id, text)
          token = settings.telegram_bot_token
          uri = URI("#{settings.telegram_api}/bot#{token}/sendMessage")

          request = Net::HTTP::Post.new(uri)
          request["Content-Type"] = "application/json"
          request.body = { chat_id: chat_id, text: text }.to_json

          Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        end

        def send_video(chat_id, file_path)
          token = settings.telegram_bot_token
          uri = URI("#{settings.telegram_api}/bot#{token}/sendVideo")

          request = Net::HTTP::Post::Multipart.new(
            uri.path,
            "chat_id" => chat_id.to_s,
            "video" => UploadIO.new(File.open(file_path), mime_type_for(file_path), File.basename(file_path))
          )

          Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        end
      end
    end
  end
end
