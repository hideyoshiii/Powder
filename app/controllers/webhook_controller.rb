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
          @menus = ["デートしたい", "デートコース提案", "デートプラン提案", "デートコース", "デートスポット", "スポット", "コース", "デートプラン", "デート", "プラン"]
          @mess_menus = @menus.select {|item| item.include?(@mess)}
          @areas = ["都心エリア", "副都心エリア", "区東エリア", "区西エリア", "区南エリア", "区北エリア", "市町村エリア"]
          @mess_area = @areas.select {|item| item.include?(@mess)}
          @citys = ["東京・丸の内・日本橋", "銀座・有楽町", "六本木・麻布・赤坂", "赤坂・虎ノ門・永田町", "新橋・汐留・浜松町", "神楽坂・飯田橋", "神田・秋葉原・御茶ノ水", "新宿", "渋谷", "池袋", "お台場", "原宿・表参道・青山", "恵比寿・代官山・中目黒", "四ツ谷・信濃町・千駄ヶ谷", "代々木・初台", "上野", "浅草・押上", "谷中・根津・千駄木", "人形町・門前仲町・葛西", "千住・綾瀬・葛飾", "両国・錦糸町・小岩", "中野・荻窪", "練馬・江古田", "品川", "目黒・白金・五反田", "下北沢", "自由が丘・二子玉川", "三軒茶屋・駒沢", "大井町・大森・蒲田", "大久保・高田馬場・早稲田", "池袋", "大塚・巣鴨・駒込", "板橋・赤羽", "吉祥寺・三鷹", "立川・八王子・青梅", "調布・府中・狛江", "町田・稲城・多摩", "小金井・国分寺・国立"]
          #,に統一
          @mess_city_g = @mess.gsub("、",",").gsub(" ",",")
          #,で区切って配列に
          @mess_city_s = @mess_city_g.split(",")
          #一番初めのものをcityと定義
          @mess_city_first = @mess_city_s.first
          #部分一致しているものを配列に
          @mess_city = @citys.select {|item| item.include?(@mess_city_first)}

	          if @mess_menus.size >= 1
	          	#エリア選択
	          	message = 
	          	message = {
		            type: 'text',
		            text: "デートコースですね。任せてください。\nまずはエリアを選んでください。"
		        },
	          	{
				  "type": "template",
				  "altText": "エリアを選択してください",
				  "template": {
				      "type": "image_carousel",
				      "columns": [
				          {
				            "imageUrl": "https://www.a-date.jp/assets/toshin.jpg",
				            "action": {
				              "type": "message",
				              "label": "都心エリア",
				              "text": "都心エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/fukutoshin.jpg",
				            "action": {
				              "type": "message",
				              "label": "副都心エリア",
				              "text": "副都心エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/kuto.jpg",
				            "action": {
				              "type": "message",
				              "label": "区東エリア",
				              "text": "区東エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/kusei.jpg",
				            "action": {
				              "type": "message",
				              "label": "区西エリア",
				              "text": "区西エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/kunan.jpg",
				            "action": {
				              "type": "message",
				              "label": "区南エリア",
				              "text": "区南エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/kuhoku.jpg",
				            "action": {
				              "type": "message",
				              "label": "区北エリア",
				              "text": "区北エリア"
				            }
				          },
				          {
				            "imageUrl": "https://www.a-date.jp/assets/shichoson.jpg",
				            "action": {
				              "type": "message",
				              "label": "市町村エリア",
				              "text": "市町村エリア"
				            }
				          }
				      ]
				  }
				}
          		client.reply_message(event['replyToken'], message)
	          else
	          	if @mess_area.size >= 1
	          		#city選択
	          		@area = @mess_area.first
	          		if @area == "都心エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、都会のデートはいいですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "都心エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/tokyo00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "東京・丸の内・日本橋",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "東京・丸の内・日本橋、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "東京・丸の内・日本橋、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ginza00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "銀座・有楽町",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "銀座・有楽町、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "銀座・有楽町、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/roppongi00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "六本木・麻布・赤坂",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "六本木・麻布・赤坂、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "六本木・麻布・赤坂、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/akasaka00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "赤坂・虎ノ門・永田町",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "赤坂・虎ノ門・永田町、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "赤坂・虎ノ門・永田町、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/shinbashi00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "新橋・汐留・浜松町",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "新橋・汐留・浜松町、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "新橋・汐留・浜松町、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/kagurazaka00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "神楽坂・飯田橋",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "神楽坂・飯田橋、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "神楽坂・飯田橋、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/kanda00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "神田・秋葉原・御茶ノ水",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "神田・秋葉原・御茶ノ水、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "神田・秋葉原・御茶ノ水、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "副都心エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、観光スポットが多くて楽しめるエリアですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "副都心エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/shinnjuku00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "新宿",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "新宿、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "新宿、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/shibuya00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "渋谷",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "渋谷、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "渋谷、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ikebukuro00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "池袋",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "池袋、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "池袋、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/odaiba00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "お台場",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "お台場、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "お台場、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/harajuku00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "原宿・表参道・青山",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "原宿・表参道・青山、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "原宿・表参道・青山、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ebisu00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "恵比寿・代官山・中目黒",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "恵比寿・代官山・中目黒、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "恵比寿・代官山・中目黒、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/yotsuya00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "四ツ谷・信濃町・千駄ヶ谷",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "四ツ谷・信濃町・千駄ヶ谷、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "四ツ谷・信濃町・千駄ヶ谷、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/yoyogi00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "代々木・初台",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "代々木・初台、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "代々木・初台、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "区東エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、下町デートもいいですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "区東エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ueno00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "上野",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "上野、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "上野、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/asakusa00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "浅草・押上",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "浅草・押上、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "浅草・押上、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/taninaka00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "谷中・根津・千駄木",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "谷中・根津・千駄木、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "谷中・根津・千駄木、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ningyocho00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "人形町・門前仲町・葛西",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "人形町・門前仲町・葛西、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "人形町・門前仲町・葛西、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/senju00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "千住・綾瀬・葛飾",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "千住・綾瀬・葛飾、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "千住・綾瀬・葛飾、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/ryogoku00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "両国・錦糸町・小岩",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "両国・錦糸町・小岩、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "両国・錦糸町・小岩、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "区西エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、独特のカルチャーがあって歩いているだけで楽しめるエリアですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "区西エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/tokyo00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "中野・荻窪",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "中野・荻窪、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "中野・荻窪、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/tokyo00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "練馬・江古田",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "練馬・江古田、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "練馬・江古田、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "区南エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、落ち着きのあるエリアですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "区南エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/shinagawa00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "品川",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "品川、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "品川、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/meguro00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "目黒・白金・五反田",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "目黒・白金・五反田、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "目黒・白金・五反田、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/shimokitazawa00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "下北沢",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "下北沢、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "下北沢、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/jiyugaoka00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "自由が丘・二子玉川",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "自由が丘・二子玉川、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "自由が丘・二子玉川、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/sangenchaya00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "三軒茶屋・駒沢",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "三軒茶屋・駒沢、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "三軒茶屋・駒沢、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/oicho00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "大井町・大森・蒲田",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "大井町・大森・蒲田、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "大井町・大森・蒲田、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "区北エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですね、意外と穴場なエリアでいいですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "区北エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/okubo00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "大久保・高田馬場・早稲田",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "大久保・高田馬場・早稲田、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "大久保・高田馬場・早稲田、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/otsuka00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "大塚・巣鴨・駒込",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "大塚・巣鴨・駒込、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "大塚・巣鴨・駒込、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/itabashi00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "板橋・赤羽",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "板橋・赤羽、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "板橋・赤羽、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
	          		if @area == "市町村エリア"
	          			message = {
				            type: 'text',
				            text: "#{@area}ですか、自然も多くて人気なスポットが多いエリアですね。\n次はもっと細かいエリアを選んでください"
				        },
	          			{
						  "type": "template",
						  "altText": "市町村エリアのcityを選んで下さい",
						  "template": {
						      "type": "carousel",
						      "columns": [
						         {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/kichijoji00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "吉祥寺・三鷹",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "吉祥寺・三鷹、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "吉祥寺・三鷹、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/tachikawa00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "立川・八王子・青梅",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "立川・八王子・青梅、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "立川・八王子・青梅、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/chofu00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "調布・府中・狛江",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "調布・府中・狛江、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "調布・府中・狛江、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/machida00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "町田・稲城・多摩",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "町田・稲城・多摩、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "町田・稲城・多摩、夜から"
						                }
						            ]
						          },
						          {
						            "thumbnailImageUrl": "https://www.a-date.jp/assets/koganei00.jpg",
						            "imageBackgroundColor": "#FFFFFF",
						            "title": "小金井・国分寺・国立",
						            "text": "時間帯を選択してください",
						            "defaultAction": {
						                "type": "uri",
						                "label": "View detail",
						                "uri": "https://www.a-date.jp"
						            },
						            "actions": [
						                {
						                    "type": "message",
						                    "label": "昼から",
						                    "text": "小金井・国分寺・国立、昼から"
						                },
						                {
						                    "type": "message",
						                    "label": "夜から",
						                    "text": "小金井・国分寺・国立、夜から"
						                }
						            ]
						          }
						      ],
						      "imageAspectRatio": "rectangle",
						      "imageSize": "cover"
						  }
						}
	          		end
          			client.reply_message(event['replyToken'], message)
	          	else
		          	if @mess_city.size >= 1
		          		if @mess.include?("昼から")
		          			#昼からコース提案
		          			@city = @mess_city.first
		          			@time = "昼"
		          			#@spotsを定義
						    @spots = Spot.all
						    #@latitudeがない物を排除
						    @spots = @spots.where.not(latitude: nil)
						    #カテゴリー類定義
		          			@noons_not = ["カフェ","バー", "夜景"]
		          			@nights_not = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
		          			#@distance定義
		          			@distance = 0.5.to_f
		          			#スポット１(ランチ)
						    @spot1_city = @spots.where(city: @city)
						    @spot1_category = @spot1_city.where("large like '%ランチ%'")
						    @spot1 = @spot1_category.order("RANDOM()").first
						    #スポット２
						    unless @spot1.blank?
							    @spot2_not = @spots.where.not(title: @spot1.title)
							    @spot2_not_lunch = @spot2_not.where.not("large like '%ランチ%'")
							    @spot2_timezone = @spot2_not_lunch.where("timezone like '%昼%'")
							    @spot2_category = @spot2_timezone
						      	@noons_not.each.with_index(1) do |noon, i|
						          @spot2_category = @spot2_category.where.not("large like '%#{noon}%'")
						      	end
							    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
							    until @spot2_distance.size >= 1 do
							      @distance = @distance + 0.2.to_f
							      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
							    end
							    @spot2 = @spot2_distance.order("RANDOM()").first
							end
							#スポット３
						    unless @spot2.blank?
							    @spot3_not = @spots.where.not(title: @spot1.title)
							    @spot3_not = @spot3_not.where.not(title: @spot2.title)
							    @spot3_not_lunch = @spot3_not.where.not("large like '%ランチ%'")
							    @spot3_timezone = @spot3_not_lunch.where("timezone like '%昼%'")
							    @spot3_category = @spot3_timezone
						      	@noons_not.each.with_index(1) do |noon, i|
						          @spot3_category = @spot3_category.where.not("large like '%#{noon}%'")
						      	end
							    @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
							    until @spot3_distance.size >= 1 do
							      @distance = @distance + 0.2.to_f
							      @spot3_distance = @spot3_category.near([@spot2.latitude, @spot2.longitude], @distance, :units => :km, :order => false)
							    end
							    @spot3 = @spot3_distance.order("RANDOM()").first
							end
							#スポット４(ディナー)
							unless @spot3.blank?
							    @spot4_not = @spots.where.not(title: @spot1.title)
							    @spot4_not = @spot4_not.where.not(title: @spot2.title)
							    @spot4_not = @spot4_not.where.not(title: @spot3.title)
							    @spot4_category = @spot4_not.where("large like '%ディナー%'")
							    @spot4_distance = @spot4_category.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
							    until @spot4_distance.size >= 1 do
							      @distance = @distance.to_f + 0.2.to_f
							      @spot4_distance = @spot4_price.near([@spot3.latitude, @spot3.longitude], @distance, :units => :km, :order => false)
							    end
							    @spot4 = @spot4_distance.order("RANDOM()").first
						    end
						    #スポット５
						    unless @spot4.blank?
							    @spot5_not = @spots.where.not(title: @spot1.title)
							    @spot5_not = @spot5_not.where.not(title: @spot2.title)
							    @spot5_not = @spot5_not.where.not(title: @spot3.title)
							    @spot5_not = @spot5_not.where.not(title: @spot4.title)
							    @spot5_not_dinner = @spot5_not.where.not("large like '%ディナー%'")
							    @spot5_timezone = @spot5_not_dinner.where("timezone like '%夜%'")
							    @spot5_category = @spot5_timezone
						      	@nights_not.each.with_index(1) do |night, i|
						          @spot5_category = @spot5_category.where.not("large like '%#{night}%'")
						      	end
							    @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
							    until @spot5_distance.size >= 1 do
							      @distance = @distance + 0.2.to_f
							      @spot5_distance = @spot5_category.near([@spot4.latitude, @spot4.longitude], @distance, :units => :km, :order => false)
							    end
							    @spot5 = @spot5_distance.order("RANDOM()").first
							end

							   #配列を作る
							   @ss = []
							   unless @spot1.blank?
							     @ss.push(@spot1.id)
							   end
							   unless @spot2.blank?
							     @ss.push(@spot2.id)
							   end
							   unless @spot3.blank?
							     @ss.push(@spot3.id)
							   end
							   unless @spot4.blank?
							     @ss.push(@spot4.id)
							   end
							   unless @spot5.blank?
							     @ss.push(@spot5.id)
							   end

							    #ツイート用のURL作成
							    @timezone = "noon"
							    @url = "https://www.a-date.jp"
							    @url = @url.to_s + '/plan?'
							    @ss.each.with_index(1) do |s, i|
							      @url = @url.to_s + "&ss%5B%5D=#{s}"
							    end
							    @url = @url.to_s + "&timezone=#{@timezone}"

							    message = {
						            type: 'text',
						            text: "#{@city}で#{@time}からのデートですね。\nこちらのコースはいかがでしょうか？"
						          },
						          {
						            type: 'text',
						            text: @url
						          }
						          
		          			
          					client.reply_message(event['replyToken'], message)
		          		else
		          			if @mess.include?("夜から")
		          				#夜からコース提案
			          			@city = @mess_city.first
			          			@time = "夜"
			          			#@spotsを定義
							    @spots = Spot.all
							    #@latitudeがない物を排除
							    @spots = @spots.where.not(latitude: nil)
							    #カテゴリー類定義
			          			@noons_not = ["カフェ","バー", "夜景"]
			          			@nights_not = ["アニマルカフェ", "映画", "ショップ・雑貨屋", "スポーツ", "プラネタリウム", "動物園", "水族館", "美術館", "遊園地", "食べ歩き", "スパ・温泉", "ゲームセンター", "お寺・神社", "劇場", "コンセプトカフェ・バー", "体験", "ストリート", "複合施設", "その他"]
			          			#@distance定義
			          			@distance = 0.5.to_f
			          			#スポット１(ランチ)
							    @spot1_city = @spots.where(city: @city)
							    @spot1_category = @spot1_city.where("large like '%ディナー%'")
							    @spot1 = @spot1_category.order("RANDOM()").first
							    #スポット２
							    unless @spot1.blank?
								    @spot2_not = @spots.where.not(title: @spot1.title)
								    @spot2_not_lunch = @spot2_not.where.not("large like '%ディナー%'")
								    @spot2_timezone = @spot2_not_lunch.where("timezone like '%夜%'")
								    @spot2_category = @spot2_timezone
							      	@nights_not.each.with_index(1) do |night, i|
							          @spot2_category = @spot2_category.where.not("large like '%#{night}%'")
							      	end
								    @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
								    until @spot2_distance.size >= 1 do
								      @distance = @distance + 0.2.to_f
								      @spot2_distance = @spot2_category.near([@spot1.latitude, @spot1.longitude], @distance, :units => :km, :order => false)
								    end
								    @spot2 = @spot2_distance.order("RANDOM()").first
								end

								#配列を作る
							   @ss = []
							   unless @spot1.blank?
							     @ss.push(@spot1.id)
							   end
							   unless @spot2.blank?
							     @ss.push(@spot2.id)
							   end

							    #ツイート用のURL作成
							    @timezone = "noon"
							    @url = "https://www.a-date.jp"
							    @url = @url.to_s + '/plan?'
							    @ss.each.with_index(1) do |s, i|
							      @url = @url.to_s + "&ss%5B%5D=#{s}"
							    end
							    @url = @url.to_s + "&timezone=#{@timezone}"

							    message = {
						            type: 'text',
						            text: "#{@city}で#{@time}からのデートですね。\nこちらのコースはいかがでしょうか？"
						          },
						          {
						            type: 'text',
						            text: @url
						          }

						        client.reply_message(event['replyToken'], message)
		          				
		          			else
		          				#timezone選択ボタン
		          				@city = @mess_city.first
		          				if @city == "東京・丸の内・日本橋"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/tokyo00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "銀座・有楽町"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ginza00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "六本木・麻布・赤坂"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/roppongi00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "赤坂・虎ノ門・永田町"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/akasaka00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "新橋・汐留・浜松町"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/shinbashi00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "神楽坂・飯田橋"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/kagurazaka00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "神田・秋葉原・御茶ノ水"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/kanda00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "新宿"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/shinnjuku00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "渋谷"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/shibuya00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "池袋"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ikebukuro00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "お台場"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/odaiba00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "原宿・表参道・青山"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/harajuku00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "恵比寿・代官山・中目黒"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ebisu00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "四ツ谷・信濃町・千駄ヶ谷"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/yotsuya00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "代々木・初台"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/yoyogi00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "上野"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ueno00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "浅草・押上"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/asakusa00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "谷中・根津・千駄木"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/taninaka00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "人形町・門前仲町・葛西"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ningyocho00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "千住・綾瀬・葛飾"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/senju00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "両国・錦糸町・小岩"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/ryogoku00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "中野・荻窪"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/nakano00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "練馬・江古田"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/nerima00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "品川"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/shinagawa00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "目黒・白金・五反田"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/meguro00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "下北沢"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/shimokitazawa00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "自由が丘・二子玉川"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/jiyugaoka00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "三軒茶屋・駒沢"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/sangenchaya00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "大井町・大森・蒲田"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/oicho00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "大久保・高田馬場・早稲田"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/okubo00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "大塚・巣鴨・駒込"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/otsuka00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "板橋・赤羽"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/itabashi00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "吉祥寺・三鷹"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/kichijoji00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "立川・八王子・青梅"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/tachikawa00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "調布・府中・狛江"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/chofu00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "町田・稲城・多摩"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/machida00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								if @city == "小金井・国分寺・国立"
			          				message = {
							            type: 'text',
							            text: "#{@city}ですね。\nどの時間帯からデートしますか？"
							        },
			          				{
									  "type": "template",
									  "altText": "時間帯を選択してください",
									  "template": {
									      "type": "buttons",
									      "thumbnailImageUrl": "https://www.a-date.jp/assets/koganei00.jpg",
									      "imageAspectRatio": "rectangle",
									      "imageSize": "cover",
									      "imageBackgroundColor": "#FFFFFF",
									      "title": @city,
									      "text": "時間帯を選択してください",
									      "defaultAction": {
									          "type": "uri",
									          "label": "View detail",
									          "uri": "https://www.a-date.jp"
									      },
									      "actions": [
									          {
									            "type": "message",
							                    "label": "昼から",
							                    "text": "#{@city}、昼から"
									          },
									          {
							                    "type": "message",
							                    "label": "夜から",
							                    "text": "#{@city}、夜から"
							                  }
									      ]
									  }
									}
								end
								client.reply_message(event['replyToken'], message)
		          			end
		          		end
		          	else
		          		#その他の時
		          		message = {
				            type: 'text',
				            text: "ショーンはまだ勉強不足ですので会話ができません。\n\n「デートしたい」と言っていただくとコースを提案させていただきます。\n\n詳細な条件でコースがつくりたい場合はWebサイトへどうぞ。\nhttps://www.a-date.jp"
				          }
		          		client.reply_message(event['replyToken'], message)
		          	end
		         end
	      	  end

	      	when Line::Bot::Event::MessageType::Sticker
	  		#その他の時
	  		message = {
	            type: 'text',
	            text: "ショーンはまだ勉強不足ですので会話ができません。\n\n「デートしたい」と言っていただくとコースを提案させていただきます。\n\n詳細な条件でコースがつくりたい場合はWebサイトへどうぞ。\nhttps://www.a-date.jp"
	          }
	  		client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end
end