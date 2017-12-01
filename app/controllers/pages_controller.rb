class PagesController < ApplicationController

  def index
  end

  def prefecture
  end


  def hokkaido
  	@spots = Spot.where(prefecture: "北海道").all.reverse_order
  	@q = @spots.ransack(params[:q])
  end

  def hokkaido1
  	@spots = Spot.where(prefecture: "北海道").all.reverse_order
  	@q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def aomori
    @spots = Spot.where(prefecture: "青森").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def aomori1
    @spots = Spot.where(prefecture: "青森").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def iwate
    @spots = Spot.where(prefecture: "岩手").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def iwate1
    @spots = Spot.where(prefecture: "岩手").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def miyagi
    @spots = Spot.where(prefecture: "宮城").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def miyagi1
    @spots = Spot.where(prefecture: "宮城").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def akita
    @spots = Spot.where(prefecture: "秋田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def akita1
    @spots = Spot.where(prefecture: "秋田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def yamagata
    @spots = Spot.where(prefecture: "山形").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def yamagata1
    @spots = Spot.where(prefecture: "山形").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def fukushima
    @spots = Spot.where(prefecture: "福島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def fukushima1
    @spots = Spot.where(prefecture: "福島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def ibaraki
    @spots = Spot.where(prefecture: "茨城").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def ibaraki1
    @spots = Spot.where(prefecture: "茨城").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tochigi
    @spots = Spot.where(prefecture: "栃木").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tochigi1
    @spots = Spot.where(prefecture: "栃木").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def gunma
    @spots = Spot.where(prefecture: "群馬").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def gunma1
    @spots = Spot.where(prefecture: "群馬").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def saitama
    @spots = Spot.where(prefecture: "埼玉").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def saitama1
    @spots = Spot.where(prefecture: "埼玉").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def chiba
    @spots = Spot.where(prefecture: "千葉").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def chiba1
    @spots = Spot.where(prefecture: "千葉").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo
    @spots = Spot.where(prefecture: "東京").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo1
    @spots = Spot.where(prefecture: "東京").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end


  def tokyo2
    @spots = Spot.where(city: "下北沢・明大前・成城学園前").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo2e
    @spots = Spot.where(city: "下北沢・明大前・成城学園前").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo3
    @spots = Spot.where(city: "錦糸町・浅草・新小岩").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo3e
    @spots = Spot.where(city: "錦糸町・浅草・新小岩").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo4
    @spots = Spot.where(city: "渋谷・恵比寿・中目黒・目黒").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo4e
    @spots = Spot.where(city: "渋谷・恵比寿・中目黒・目黒").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo5
    @spots = Spot.where(city: "自由が丘・三軒茶屋・二子玉川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo5e
    @spots = Spot.where(city: "自由が丘・三軒茶屋・二子玉川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo6
    @spots = Spot.where(city: "十条・王子").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo6e
    @spots = Spot.where(city: "十条・王子").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo7
    @spots = Spot.where(city: "新橋・浜松町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo7e
    @spots = Spot.where(city: "新橋・浜松町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo8
    @spots = Spot.where(city: "神田・秋葉原・御茶ノ水").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo8e
    @spots = Spot.where(city: "神田・秋葉原・御茶ノ水").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo9
    @spots = Spot.where(city: "人形町・門前仲町・葛西").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo9e
    @spots = Spot.where(city: "人形町・門前仲町・葛西").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo10
    @spots = Spot.where(city: "水道橋・飯田橋・神楽坂・本郷").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo10e
    @spots = Spot.where(city: "水道橋・飯田橋・神楽坂・本郷").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo11
    @spots = Spot.where(city: "西新井・舎人").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo11e
    @spots = Spot.where(city: "西新井・舎人").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo12
    @spots = Spot.where(city: "赤坂・永田町・虎ノ門").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo12e
    @spots = Spot.where(city: "赤坂・永田町・虎ノ門").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo13
    @spots = Spot.where(city: "大井町・大森・蒲田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo13e
    @spots = Spot.where(city: "大井町・大森・蒲田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo14
    @spots = Spot.where(city: "池袋・巣鴨・駒込").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo14e
    @spots = Spot.where(city: "池袋・巣鴨・駒込").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo15
    @spots = Spot.where(city: "中野・吉祥寺・三鷹").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo15e
    @spots = Spot.where(city: "中野・吉祥寺・三鷹").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo16
    @spots = Spot.where(city: "東京駅・丸の内・日本橋").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo16e
    @spots = Spot.where(city: "東京駅・丸の内・日本橋").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo17
    @spots = Spot.where(city: "板橋・成増・赤羽").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo17e
    @spots = Spot.where(city: "板橋・成増・赤羽").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo18
    @spots = Spot.where(city: "品川・田町・五反田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo18e
    @spots = Spot.where(city: "品川・田町・五反田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo19
    @spots = Spot.where(city: "府中・調布・多摩センター").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo19e
    @spots = Spot.where(city: "府中・調布・多摩センター").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo20
    @spots = Spot.where(city: "豊洲・お台場・湾岸").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo20e
    @spots = Spot.where(city: "豊洲・お台場・湾岸").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo21
    @spots = Spot.where(city: "北千住・綾瀬・金町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo21e
    @spots = Spot.where(city: "北千住・綾瀬・金町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo22
    @spots = Spot.where(city: "木場・東陽町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo22e
    @spots = Spot.where(city: "木場・東陽町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo23
    @spots = Spot.where(city: "立川・八王子・青梅").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo23e
    @spots = Spot.where(city: "立川・八王子・青梅").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo24
    @spots = Spot.where(city: "練馬・江古田・田無").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo24e
    @spots = Spot.where(city: "練馬・江古田・田無").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo25
    @spots = Spot.where(city: "月島・勝どき").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo25e
    @spots = Spot.where(city: "月島・勝どき").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo26
    @spots = Spot.where(city: "銀座・有楽町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo26e
    @spots = Spot.where(city: "銀座・有楽町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo27
    @spots = Spot.where(city: "亀有・柴又").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo27e
    @spots = Spot.where(city: "亀有・柴又").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo28
    @spots = Spot.where(city: "新宿").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo28e
    @spots = Spot.where(city: "新宿").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo29
    @spots = Spot.where(city: "新大久保・高田馬場・早稲田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo29e
    @spots = Spot.where(city: "新大久保・高田馬場・早稲田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo30
    @spots = Spot.where(city: "馬込・池上").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo30e
    @spots = Spot.where(city: "馬込・池上").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo31
    @spots = Spot.where(city: "代々木・初台").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo31e
    @spots = Spot.where(city: "代々木・初台").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo32
    @spots = Spot.where(city: "原宿・表参道・青山").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo32e
    @spots = Spot.where(city: "原宿・表参道・青山").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo33
    @spots = Spot.where(city: "六本木・麻布・広尾").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo33e
    @spots = Spot.where(city: "六本木・麻布・広尾").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo34
    @spots = Spot.where(city: "四ツ谷・信濃町・千駄ヶ谷").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo34e
    @spots = Spot.where(city: "四ツ谷・信濃町・千駄ヶ谷").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo35
    @spots = Spot.where(city: "上野・浅草・日暮里").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo35e
    @spots = Spot.where(city: "上野・浅草・日暮里").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo36
    @spots = Spot.where(city: "東急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo36e
    @spots = Spot.where(city: "東急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo37
    @spots = Spot.where(city: "京王・小田急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo37e
    @spots = Spot.where(city: "京王・小田急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo38
    @spots = Spot.where(city: "小金井・国分寺・国立").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo38e
    @spots = Spot.where(city: "小金井・国分寺・国立").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end


  



  def tokyo98
  end

  def tokyo99
    @spots = Spot.where(city: "伊豆諸島・小笠原諸島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo99e
    @spots = Spot.where(city: "伊豆諸島・小笠原諸島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  

  def kanagawa
    @spots = Spot.where(prefecture: "神奈川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kanagawa1
    @spots = Spot.where(prefecture: "神奈川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def niigata
    @spots = Spot.where(prefecture: "新潟").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def niigata1
    @spots = Spot.where(prefecture: "新潟").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def toyama
    @spots = Spot.where(prefecture: "富山").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def toyama1
    @spots = Spot.where(prefecture: "富山").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def ishikawa
    @spots = Spot.where(prefecture: "石川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def ishikawa1
    @spots = Spot.where(prefecture: "石川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def fukui
    @spots = Spot.where(prefecture: "福井").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def fukui1
    @spots = Spot.where(prefecture: "福井").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def yamanashi
    @spots = Spot.where(prefecture: "山梨").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def yamanashi1
    @spots = Spot.where(prefecture: "山梨").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def nagano
    @spots = Spot.where(prefecture: "長野").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def nagano1
    @spots = Spot.where(prefecture: "長野").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def gifu
    @spots = Spot.where(prefecture: "岐阜").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def gifu1
    @spots = Spot.where(prefecture: "岐阜").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def shizuoka
    @spots = Spot.where(prefecture: "静岡").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def shizuoka1
    @spots = Spot.where(prefecture: "静岡").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def aichi
    @spots = Spot.where(prefecture: "愛知").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def aichi1
    @spots = Spot.where(prefecture: "愛知").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def mie
    @spots = Spot.where(prefecture: "三重").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def mie1
    @spots = Spot.where(prefecture: "三重").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def shiga
    @spots = Spot.where(prefecture: "滋賀").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def shiga1
    @spots = Spot.where(prefecture: "滋賀").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def kyoto
    @spots = Spot.where(prefecture: "京都").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kyoto1
    @spots = Spot.where(prefecture: "京都").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def osaka
    @spots = Spot.where(prefecture: "大阪").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def osaka1
     @spots = Spot.where(prefecture: "大阪").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def hyogo
    @spots = Spot.where(prefecture: "兵庫").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def hyogo1
    @spots = Spot.where(prefecture: "兵庫").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def nara
    @spots = Spot.where(prefecture: "奈良").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def nara1
    @spots = Spot.where(prefecture: "奈良").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def wakayama
    @spots = Spot.where(prefecture: "和歌山").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def wakayama1
    @spots = Spot.where(prefecture: "和歌山").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tottori
    @spots = Spot.where(prefecture: "鳥取").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tottori1
    @spots = Spot.where(prefecture: "鳥取").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def shimane
    @spots = Spot.where(prefecture: "島根").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def shimane1
    @spots = Spot.where(prefecture: "島根").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def okayama
    @spots = Spot.where(prefecture: "岡山").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def okayama1
    @spots = Spot.where(prefecture: "岡山").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def hiroshima
    @spots = Spot.where(prefecture: "広島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def hiroshima1
    @spots = Spot.where(prefecture: "広島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def yamaguchi
    @spots = Spot.where(prefecture: "山口").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def yamaguchi1
    @spots = Spot.where(prefecture: "山口").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokushima
    @spots = Spot.where(prefecture: "徳島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokushima1
    @spots = Spot.where(prefecture: "徳島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def kagawa
    @spots = Spot.where(prefecture: "香川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kagawa1
    @spots = Spot.where(prefecture: "香川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def ehime
    @spots = Spot.where(prefecture: "愛媛").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def ehime1
    @spots = Spot.where(prefecture: "愛媛").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def kouchi
    @spots = Spot.where(prefecture: "高知").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kouchi1
    @spots = Spot.where(prefecture: "高知").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def fukuoka
    @spots = Spot.where(prefecture: "福岡").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def fukuoka1
    @spots = Spot.where(prefecture: "福岡").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def saga
     @spots = Spot.where(prefecture: "佐賀").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def saga1
    @spots = Spot.where(prefecture: "佐賀").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def nagasaki
     @spots = Spot.where(prefecture: "長崎").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def nagasaki1
    @spots = Spot.where(prefecture: "長崎").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def kumamoto
     @spots = Spot.where(prefecture: "熊本").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kumamoto1
    @spots = Spot.where(prefecture: "熊本").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def oita
     @spots = Spot.where(prefecture: "大分").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def oita1
    @spots = Spot.where(prefecture: "大分").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def miyazaki
     @spots = Spot.where(prefecture: "宮崎").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def miyazaki1
    @spots = Spot.where(prefecture: "宮崎").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def kagoshima
     @spots = Spot.where(prefecture: "鹿児島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kagoshima1
    @spots = Spot.where(prefecture: "鹿児島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def okinawa
     @spots = Spot.where(prefecture: "沖縄").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def okinawa1
    @spots = Spot.where(prefecture: "沖縄").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def oversea
    @spots = Spot.where(prefecture: "海外").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  private

def post_params
  params.require(:sample_form).permit(
    scenes: []
  )
end


end
