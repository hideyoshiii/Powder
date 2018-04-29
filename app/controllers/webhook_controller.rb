class WebhookController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }

          @kr = event.message['text']
          @citys = ["渋谷", "新宿", "池袋"]


	          if message.has_value?("エリア")
	          	lll = {
			            type: 'text',
			            text: "エリア正解"
			          }
			          client.reply_message(event['replyToken'], lll)
	          else
	          	if @citys.where('name LIKE(?)', "%#{@kr}%")
	          		nnn = {
			            type: 'text',
			            text: "city正解"
			          }
			          client.reply_message(event['replyToken'], nnn)
	          	else
	          		client.reply_message(event['replyToken'], message)
	          	end
	      	  end


        end
      end
    }

    head :ok
  end
end