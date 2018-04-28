class WebhookController < ApplicationController
  
  protect_from_forgery :except => [:callback]
 
require 'line/bot'
require 'net/http'
 
def client
       client = Line::Bot::Client.new { |config|
 config.channel_secret = 'd2d5c258acd03feab6fbd012692f2fcf'
 config.channel_token = 'rVDPe/rfvnbow62VjKgjB+6YXo55/z1HDRbo7Ctbhk3XY+mYj/aEp1MKuN0tV4mUbBAvisPtDkAerJZz7p/eeJCHfM6ONH8M/f8bv2nyjdjCOkuLVa39vdsiqN0aivJF7LezBftVN69MJ6WLWGDceQdB04t89/1O/w1cDnyilFU='
 }
end
 
 
 
def callback
 
  body = request.body.read
 
  signature = request.env['HTTP_X_LINE_SIGNATURE']
 
  event = params["events"][0]
  event_type = event["type"]
 
  #送られたテキストメッセージをinput_textに取得
  input_text = event["message"]["text"]
 
  events = client.parse_events_from(body)
 
  events.each { |event|
 
    case event
      when Line::Bot::Event::Message
        case event.type
          #テキストメッセージが送られた場合、そのままおうむ返しする
          when Line::Bot::Event::MessageType::Text
             message = {
                  type: 'text',
                  text: input_text
                  }
 
          
         end #event.type
         #メッセージを返す
         client.reply_message(event['replyToken'],message)
    end #event
 } #events.each
 
end  #def
 
 
end