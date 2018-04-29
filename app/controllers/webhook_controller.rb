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

          @mess = event.message['text']
          @menus = ["エリア"]
          @areas = ["都心", "副都心", "区東", "区西", "区南", "区北", "市町村"]
          @mess_area = @areas.select {|item| item.include?(@mess)}
          @citys = ["東京・丸の内・日本橋", "銀座・有楽町", "六本木・麻布・赤坂", "赤坂・虎ノ門・永田町", "新橋・汐留・浜松町", "神楽坂・飯田橋", "神田・秋葉原・御茶ノ水", "新宿", "渋谷", "池袋", "お台場", "原宿・表参道・青山", "恵比寿・代官山・中目黒", "四ツ谷・信濃町・千駄ヶ谷", "代々木・初台", "上野", "浅草・押上", "谷中・根津・千駄木", "人形町・門前仲町・葛西", "千住・綾瀬・葛飾", "両国・錦糸町・小岩", "中野・荻窪", "練馬・江古田", "品川", "目黒・白金・五反田", "下北沢", "自由が丘・二子玉川", "三軒茶屋・駒沢", "大井町・大森・蒲田", "大久保・高田馬場・早稲田", "池袋", "大塚・巣鴨・駒込", "板橋・赤羽", "吉祥寺・三鷹", "立川・八王子・青梅", "調布・府中・狛江", "町田・稲城・多摩", "小金井・国分寺・国立", "伊豆諸島・小笠原"]
          #,に統一
          @mess_city_g = @mess.gsub("、",",").gsub(" ",",")
          #,で区切って配列に
          @mess_city_s = @mess_city_g.split(",")
          #一番初めのものをcityと定義
          @mess_city_first = @mess_city_s.first
          #部分一致しているものを配列に
          @mess_city = @citys.select {|item| item.include?(@mess_city_first)}

	          if @menus.include?(@mess)
	          	#エリア選択
	          	message = {
            type: 'text',
            text: "エリアを選択してね"
          }
          client.reply_message(event['replyToken'], message)
	          else
	          	if @mess_area.size >= 1
	          		#city選択
	          		message = {
            type: 'text',
            text: "cityを選択してね"
          }
          client.reply_message(event['replyToken'], message)
	          	else
		          	if @mess_city.size >= 1
		          		if @mess.include?("昼から")
		          			#昼からコース提案
		          			@city = @mess_city.first
		          			message = {
            type: 'text',
            text: "#{@city}の昼からのコースだよん"
          }
          client.reply_message(event['replyToken'], message)
		          		else
		          			if @mess.include?("夜から")
		          				#夜からコース提案
		          				@city = @mess_city.first
		          				message = {
            type: 'text',
            text: "#{@city}の夜からのコースだよん"
          }
          client.reply_message(event['replyToken'], message)
		          			else
		          				#timezone選択ボタン
		          				message = {
            type: 'text',
            text: "timezoneボタンだよん"
          }
          client.reply_message(event['replyToken'], message)
		          			end
		          		end
		          	else
		          		#それ以外はオウム返し
		          		client.reply_message(event['replyToken'], message)
		          	end
		         end
	      	  end


        end
      end
    }

    head :ok
  end
end