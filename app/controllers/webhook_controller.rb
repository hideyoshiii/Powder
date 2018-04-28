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


          if message.has_value?("恵比寿")
          	@nights = ["カフェ","バー", "夜景"]
          	@nights_not = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
          	#@spotsを定義
		   	@spots = Spot.all
		   	#@latitudeがない物を排除
		   	@spots = @spots.where.not(latitude: nil)
		   	#スポット１
		    @spot1_city = @spots.where(city: "恵比寿・代官山・中目黒")
		    @spot1_category = @spot1_city.where("large like '%ディナー%'")
		    @spot1 = @spot1_price.order("RANDOM()").first
		    #スポット２
		    @spot2_not = @spots.where.not(title: @spot1.title)
		    @spot2_not_lunch = @spot2_not.where.not("large like '%ディナー%'")
		    @spot2_timezone = @spot2_not_lunch.where("timezone like '%夜%'")
		    @spot2_category = @spot2_timezone
		    @spot2_category_2 = @spot2_timezone
		    @spot2_category = @spot2_category.where(
		      @nights.map { |attr|  "\"spots\".\"large\" LIKE ?" }.join(' OR '),
		      *@nights.map { |attr| "%#{attr}%" }
		      )
		    if @spot2_category.blank?
		      @nights_not.each.with_index(1) do |night, i|
		        @spot2_category = @spot2_category_2.where.not("large like '%#{night}%'")
		      end
		    end
		    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
		    until @spot2_distance.size >= 1 do
		      @distance = @distance + 0.2.to_f
		      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
		    end
		    @spot2 = @spot2_distance.order("RANDOM()").first

		    	#配列を作る
			   @ss = []
			   unless @spot1.blank?
			     @ss.push(@spot1.id)
			   end
			   unless @spot2.blank?
			     @ss.push(@spot2.id)
			   end
			   params[:ss] = []
			   params[:ss] = @ss

			   #ツイート用のURL作成
			    @timezone = "night"
			    @url = root_url(only_path: false)
			    @url = @url.to_s + '/plan?'
			    params[:ss].each.with_index(1) do |s, i|
			      @url = @url.to_s + "&ss%5B%5D=#{s}"
			    end
			    @url = @url.to_s + "&timezone=#{@timezone}"

			    kkk = {
		            type: 'text',
		            text: @url
		          }

		        client.reply_message(event['replyToken'], kkk)

          else


          client.reply_message(event['replyToken'], message)
      		end
        end
      end
    }

    head :ok
  end
end