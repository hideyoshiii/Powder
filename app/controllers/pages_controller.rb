class PagesController < ApplicationController
  def index
  end

  def prefecture
  end


  def hokkaido
  	@spots = Spot.where(prefecture: "東京").all.reverse_order

  	# Ransack q のチェックボックス一覧
    if params[:q].present? 

      if params[:q][:city_eq_any].present?
        session[:city_eq_any] = params[:q][:city_eq_any]
        session[:Izushoto] = session[:city_eq_any].include?("伊豆諸島・小笠原諸島")
        session[:Shimokitazawa] = session[:city_eq_any].include?("下北沢・明大前・成城学園前")
        session[:Kinshicho] = session[:city_eq_any].include?("錦糸町・浅草・新小岩")
        session[:Shibuya] = session[:city_eq_any].include?("渋谷・恵比寿・中目黒・目黒")
        session[:Giyugaoka] = session[:city_eq_any].include?("自由が丘・三軒茶屋・二子玉川")
        session[:Jujo] = session[:city_eq_any].include?("十条・王子")
        session[:Shinbashi] = session[:city_eq_any].include?("新橋・浜松町")
        session[:Kanda] = session[:city_eq_any].include?("神田・秋葉原・御茶ノ水")
        session[:Ningyocho] = session[:city_eq_any].include?("人形町・門前仲町・葛西")
        session[:Suidoubashi] = session[:city_eq_any].include?("水道橋・飯田橋・神楽坂・本郷")
        session[:Nishiarai] = session[:city_eq_any].include?("西新井・舎人")
        session[:Akasaka] = session[:city_eq_any].include?("赤坂・永田町・虎ノ門")
        session[:Oimachi] = session[:city_eq_any].include?("大井町・大森・蒲田")
        session[:Ikebukuro] = session[:city_eq_any].include?("池袋・巣鴨・駒込")
        session[:Nakano] = session[:city_eq_any].include?("中野・吉祥寺・三鷹")
        session[:Tokyoeki] = session[:city_eq_any].include?("東京駅・丸の内・日本橋")
        session[:Itabashi] = session[:city_eq_any].include?("板橋・成増・赤羽")
        session[:Shinagawa] = session[:city_eq_any].include?("品川・田町・五反田")
        session[:Fuchu] = session[:city_eq_any].include?("府中・調布・多摩センター")
        session[:Toyosu] = session[:city_eq_any].include?("豊洲・お台場・湾岸")

        session[:Kitasenju] = session[:city_eq_any].include?("北千住・綾瀬・金町")
        session[:Koba] = session[:city_eq_any].include?("木場・東陽町")
        session[:Tachikawa] = session[:city_eq_any].include?("立川・八王子・青梅")
        session[:Nerima] = session[:city_eq_any].include?("練馬・江古田・田無")
        session[:Tsukishima] = session[:city_eq_any].include?("月島・勝どき")
        session[:Ginza] = session[:city_eq_any].include?("銀座・有楽町")
        session[:Kameari] = session[:city_eq_any].include?("亀有・柴又")
        session[:Shinjuku] = session[:city_eq_any].include?("新宿")
        session[:Shinokubo] = session[:city_eq_any].include?("新大久保・高田馬場・早稲田")
        session[:Umagome] = session[:city_eq_any].include?("馬込・池上")

        session[:Yoyogi] = session[:city_eq_any].include?("代々木・初台")
        session[:Harajuku] = session[:city_eq_any].include?("原宿・表参道・青山")
        session[:Roppongi] = session[:city_eq_any].include?("六本木・麻布・広尾")
        session[:Yotsuya] = session[:city_eq_any].include?("四ツ谷・信濃町・千駄ヶ谷")
        session[:Ueno] = session[:city_eq_any].include?("上野・浅草・日暮里")
        session[:Tokyu] = session[:city_eq_any].include?("東急沿線")
        session[:Keio] = session[:city_eq_any].include?("京王・小田急沿線")
        session[:Koganei] = session[:city_eq_any].include?("小金井・国分寺・国立")
        
      else
        session[:city_eq_any] = ""
        session[:Izushoto] = false
        session[:Shimokitazawa] = false
        session[:Kinshicho] = false
        session[:Shibuya] = false
        session[:Giyugaoka] = false
        session[:Jujo] = false
        session[:Shinbashi] = false
        session[:Kanda] = false
        session[:Ningyocho] = false
        session[:Suidoubashi] = false
        session[:Nishiarai] = false
        session[:Akasaka] = false
        session[:Oimachi] = false
        session[:Ikebukuro] = false
        session[:Nakano] = false
        session[:Tokyoeki] = false
        session[:Itabashi] = false
        session[:Shinagawa] = false
        session[:Fuchu] = false
        session[:Toyosu] = false

        session[:Kitasenju] = false
        session[:Koba] = false
        session[:Tachikawa] = false
        session[:Nerima] = false
        session[:Tsukishima] = false
        session[:Ginza] = false
        session[:Kameari] = false
        session[:Shinjuku] = false
        session[:Shinokubo] = false
        session[:Umagome] = false

        session[:KYoyogi] = false
        session[:Harajuku] = false
        session[:Roppongi] = false
        session[:Yotsuya] = false
        session[:Ueno] = false
        session[:Tokyu] = false
        session[:Keio] = false
        session[:Koganei] = false
        
      end     

     
    end 

    # Q条件をまとめたものをセッションQに入れる
    session[:q] = {"city_eq_any"=>session[:city_eq_any]}

    # ransack検索
    @search = @spots.ransack(session[:q])
    @result = @search.result(distinct: true)

     #リスティングデータを配列にしてまとめる 
    @arrlistings = @result.to_a
  end

  def hokkaido1

  	@sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "癒し", "夜景", "テーマパーク", "フォトジェニック", "朝食", "ランチ", "ディナー", "春", "夏", "秋", "冬"]

  	@spots = Spot.where(prefecture: "東京").all.reverse_order

  	# Ransack q のチェックボックス一覧
    if params[:q].present? 

      if params[:q][:city_eq_any].present?
        session[:city_eq_any] = params[:q][:city_eq_any]
        session[:Izushoto] = session[:city_eq_any].include?("伊豆諸島・小笠原諸島")
        session[:Shimokitazawa] = session[:city_eq_any].include?("下北沢・明大前・成城学園前")
        session[:Kinshicho] = session[:city_eq_any].include?("錦糸町・浅草・新小岩")
        session[:Shibuya] = session[:city_eq_any].include?("渋谷・恵比寿・中目黒・目黒")
        session[:Giyugaoka] = session[:city_eq_any].include?("自由が丘・三軒茶屋・二子玉川")
        session[:Jujo] = session[:city_eq_any].include?("十条・王子")
        session[:Shinbashi] = session[:city_eq_any].include?("新橋・浜松町")
        session[:Kanda] = session[:city_eq_any].include?("神田・秋葉原・御茶ノ水")
        session[:Ningyocho] = session[:city_eq_any].include?("人形町・門前仲町・葛西")
        session[:Suidoubashi] = session[:city_eq_any].include?("水道橋・飯田橋・神楽坂・本郷")
        session[:Nishiarai] = session[:city_eq_any].include?("西新井・舎人")
        session[:Akasaka] = session[:city_eq_any].include?("赤坂・永田町・虎ノ門")
        session[:Oimachi] = session[:city_eq_any].include?("大井町・大森・蒲田")
        session[:Ikebukuro] = session[:city_eq_any].include?("池袋・巣鴨・駒込")
        session[:Nakano] = session[:city_eq_any].include?("中野・吉祥寺・三鷹")
        session[:Tokyoeki] = session[:city_eq_any].include?("東京駅・丸の内・日本橋")
        session[:Itabashi] = session[:city_eq_any].include?("板橋・成増・赤羽")
        session[:Shinagawa] = session[:city_eq_any].include?("品川・田町・五反田")
        session[:Fuchu] = session[:city_eq_any].include?("府中・調布・多摩センター")
        session[:Toyosu] = session[:city_eq_any].include?("豊洲・お台場・湾岸")

        session[:Kitasenju] = session[:city_eq_any].include?("北千住・綾瀬・金町")
        session[:Koba] = session[:city_eq_any].include?("木場・東陽町")
        session[:Tachikawa] = session[:city_eq_any].include?("立川・八王子・青梅")
        session[:Nerima] = session[:city_eq_any].include?("練馬・江古田・田無")
        session[:Tsukishima] = session[:city_eq_any].include?("月島・勝どき")
        session[:Ginza] = session[:city_eq_any].include?("銀座・有楽町")
        session[:Kameari] = session[:city_eq_any].include?("亀有・柴又")
        session[:Shinjuku] = session[:city_eq_any].include?("新宿")
        session[:Shinokubo] = session[:city_eq_any].include?("新大久保・高田馬場・早稲田")
        session[:Umagome] = session[:city_eq_any].include?("馬込・池上")

        session[:Yoyogi] = session[:city_eq_any].include?("代々木・初台")
        session[:Harajuku] = session[:city_eq_any].include?("原宿・表参道・青山")
        session[:Roppongi] = session[:city_eq_any].include?("六本木・麻布・広尾")
        session[:Yotsuya] = session[:city_eq_any].include?("四ツ谷・信濃町・千駄ヶ谷")
        session[:Ueno] = session[:city_eq_any].include?("上野・浅草・日暮里")
        session[:Tokyu] = session[:city_eq_any].include?("東急沿線")
        session[:Keio] = session[:city_eq_any].include?("京王・小田急沿線")
        session[:Koganei] = session[:city_eq_any].include?("小金井・国分寺・国立")
        
      else
        session[:city_eq_any] = ""
        session[:Izushoto] = false
        session[:Shimokitazawa] = false
        session[:Kinshicho] = false
        session[:Shibuya] = false
        session[:Giyugaoka] = false
        session[:Jujo] = false
        session[:Shinbashi] = false
        session[:Kanda] = false
        session[:Ningyocho] = false
        session[:Suidoubashi] = false
        session[:Nishiarai] = false
        session[:Akasaka] = false
        session[:Oimachi] = false
        session[:Ikebukuro] = false
        session[:Nakano] = false
        session[:Tokyoeki] = false
        session[:Itabashi] = false
        session[:Shinagawa] = false
        session[:Fuchu] = false
        session[:Toyosu] = false

        session[:Kitasenju] = false
        session[:Koba] = false
        session[:Tachikawa] = false
        session[:Nerima] = false
        session[:Tsukishima] = false
        session[:Ginza] = false
        session[:Kameari] = false
        session[:Shinjuku] = false
        session[:Shinokubo] = false
        session[:Umagome] = false

        session[:KYoyogi] = false
        session[:Harajuku] = false
        session[:Roppongi] = false
        session[:Yotsuya] = false
        session[:Ueno] = false
        session[:Tokyu] = false
        session[:Keio] = false
        session[:Koganei] = false
        
      end    

     
    end 

    # Q条件をまとめたものをセッションQに入れる
    session[:q] = {"city_eq_any"=>session[:city_eq_any]}

    # ransack検索
    @search = @spots.ransack(session[:q])
    @result = @search.result(distinct: true)

     #リスティングデータを配列にしてまとめる 
    @arrlistings = @result.to_a


    if params[:sample_form].nil?
    @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "癒し", "夜景", "テーマパーク", "フォトジェニック", "朝食", "ランチ", "ディナー", "春", "夏", "秋", "冬"]
	else
	@scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
	end
	
  end

  def aomori
  end

  def iwate
  end

  def miyagi
  end

  def akita
  end

  def yamagata
  end

  def fukushima
  end

  def ibaraki
  end

  def tochigi
  end

  def gunma
  end

  def saitama
  end

  def chiba
  end

  def tokyo
  end

  def kanagawa
  end

  def niigata
  end

  def toyama
  end

  def ishikawa
  end

  def fukui
  end

  def yamanashi
  end

  def nagano
  end

  def gifu
  end

  def shizuoka
  end

  def aichi
  end

  def mie
  end

  def shiga
  end

  def kyoto
  end

  def osaka
  end

  def hyogo
  end

  def nara
  end

  def wakayama
  end

  def tottori
  end

  def shimane
  end

  def okayama
  end

  def hiroshima
  end

  def yamaguchi
  end

  def tokushima
  end

  def kagawa
  end

  def ehime
  end

  def kouchi
  end

  def fukuoka
  end

  def saga
  end

  def nagasaki
  end

  def kumamoto
  end

  def oita
  end

  def miyaszaki
  end

  def kagoshima
  end

  def okinawa
  end

  def oversea
  end

  private

def post_params
  params.require(:sample_form).permit(
    scenes: []
  )
end


end
