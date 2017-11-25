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
  	@sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

  	@spots = Spot.where(prefecture: "北海道").all.reverse_order
  	@q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
  	else
  	  @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
  	end
  end

  def aomori
    @spots = Spot.where(prefecture: "青森").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def aomori1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "青森").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def iwate
    @spots = Spot.where(prefecture: "岩手").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def iwate1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "岩手").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def miyagi
    @spots = Spot.where(prefecture: "宮城").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def miyagi1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "宮城").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def akita
    @spots = Spot.where(prefecture: "秋田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def akita1
     @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "秋田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def yamagata
    @spots = Spot.where(prefecture: "山形").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def yamagata1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "山形").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def fukushima
    @spots = Spot.where(prefecture: "福島").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def fukushima1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "福島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def ibaraki
  end

  def ibaraki1
  end

  def tochigi
  end

  def tochigi1
  end

  def gunma
  end

  def gunma1
  end

  def saitama
  end

  def saitama1
  end

  def chiba
  end

  def chiba1
  end

  def tokyo
    @spots = Spot.where(prefecture: "東京").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "東京").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end


  def tokyo2
    @spots = Spot.where(city: "下北沢・明大前・成城学園前").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo2e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "下北沢・明大前・成城学園前").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo3
    @spots = Spot.where(city: "錦糸町・浅草・新小岩").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo3e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "錦糸町・浅草・新小岩").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo4
    @spots = Spot.where(city: "渋谷・恵比寿・中目黒・目黒").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo4e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "渋谷・恵比寿・中目黒・目黒").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo5
    @spots = Spot.where(city: "自由が丘・三軒茶屋・二子玉川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo5e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "自由が丘・三軒茶屋・二子玉川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo6
    @spots = Spot.where(city: "十条・王子").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo6e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "十条・王子").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo7
    @spots = Spot.where(city: "新橋・浜松町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo7e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "新橋・浜松町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo8
    @spots = Spot.where(city: "神田・秋葉原・御茶ノ水").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo8e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "神田・秋葉原・御茶ノ水").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo9
    @spots = Spot.where(city: "人形町・門前仲町・葛西").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo9e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "人形町・門前仲町・葛西").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo10
    @spots = Spot.where(city: "水道橋・飯田橋・神楽坂・本郷").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo10e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "水道橋・飯田橋・神楽坂・本郷").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo11
    @spots = Spot.where(city: "西新井・舎人").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo11e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "西新井・舎人").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo12
    @spots = Spot.where(city: "赤坂・永田町・虎ノ門").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo12e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "赤坂・永田町・虎ノ門").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo13
    @spots = Spot.where(city: "大井町・大森・蒲田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo13e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "大井町・大森・蒲田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo14
    @spots = Spot.where(city: "池袋・巣鴨・駒込").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo14e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "池袋・巣鴨・駒込").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo15
    @spots = Spot.where(city: "中野・吉祥寺・三鷹").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo15e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "中野・吉祥寺・三鷹").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo16
    @spots = Spot.where(city: "東京駅・丸の内・日本橋").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo16e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "東京駅・丸の内・日本橋").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo17
    @spots = Spot.where(city: "板橋・成増・赤羽").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo17e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "板橋・成増・赤羽").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo18
    @spots = Spot.where(city: "品川・田町・五反田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo18e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "品川・田町・五反田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo19
    @spots = Spot.where(city: "府中・調布・多摩センター").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo19e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "府中・調布・多摩センター").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo20
    @spots = Spot.where(city: "豊洲・お台場・湾岸").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo20e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "豊洲・お台場・湾岸").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo21
    @spots = Spot.where(city: "北千住・綾瀬・金町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo21e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "北千住・綾瀬・金町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo22
    @spots = Spot.where(city: "木場・東陽町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo22e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "木場・東陽町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo23
    @spots = Spot.where(city: "立川・八王子・青梅").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo23e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "立川・八王子・青梅").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo24
    @spots = Spot.where(city: "練馬・江古田・田無").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo24e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "練馬・江古田・田無").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo25
    @spots = Spot.where(city: "月島・勝どき").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo25e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "月島・勝どき").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo26
    @spots = Spot.where(city: "銀座・有楽町").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo26e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "銀座・有楽町").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo27
    @spots = Spot.where(city: "亀有・柴又").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo27e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "亀有・柴又").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo28
    @spots = Spot.where(city: "新宿").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo28e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "新宿").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo29
    @spots = Spot.where(city: "新大久保・高田馬場・早稲田").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo29e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "新大久保・高田馬場・早稲田").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo30
    @spots = Spot.where(city: "馬込・池上").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo30e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "馬込・池上").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo31
    @spots = Spot.where(city: "代々木・初台").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo31e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "代々木・初台").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo32
    @spots = Spot.where(city: "原宿・表参道・青山").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo32e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "原宿・表参道・青山").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo33
    @spots = Spot.where(city: "六本木・麻布・広尾").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo33e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "六本木・麻布・広尾").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo34
    @spots = Spot.where(city: "四ツ谷・信濃町・千駄ヶ谷").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo34e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "四ツ谷・信濃町・千駄ヶ谷").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo35
    @spots = Spot.where(city: "上野・浅草・日暮里").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo35e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "上野・浅草・日暮里").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo36
    @spots = Spot.where(city: "東急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo36e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "東急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo37
    @spots = Spot.where(city: "京王・小田急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo37e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "京王・小田急沿線").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def tokyo38
    @spots = Spot.where(city: "小金井・国分寺・国立").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def tokyo38e
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "小金井・国分寺・国立").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
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
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(city: "伊豆諸島・小笠原諸島").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  

  def kanagawa
    @spots = Spot.where(prefecture: "神奈川").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kanagawa1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "神奈川").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def niigata
  end

  def niigata1
  end

  def toyama
  end

  def toyama1
  end

  def ishikawa
  end

  def ishikawa1
  end

  def fukui
  end

  def fukui1
  end

  def yamanashi
  end

  def yamanashi1
  end

  def nagano
  end

  def nagano1
  end

  def gifu
  end

  def gifu1
  end

  def shizuoka
  end

  def shizuoka1
  end

  def aichi
  end

  def aichi1
  end

  def mie
  end

  def mie1
  end

  def shiga
  end

  def shiga1
  end

  def kyoto
    @spots = Spot.where(prefecture: "京都").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def kyoto1
     @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "京都").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def osaka
    @spots = Spot.where(prefecture: "大阪").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def osaka1
     @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "大阪").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def hyogo
  end

  def hyogo1
  end

  def nara
  end

  def nara1
  end

  def wakayama
  end

  def wakayama1
  end

  def tottori
  end

  def tottori1
  end

  def shimane
  end

  def shimane1
  end

  def okayama
  end

  def okayama1
  end

  def hiroshima
  end

  def hiroshima1
  end

  def yamaguchi
  end

  def yamaguchi1
  end

  def tokushima
  end

  def tokushima1
  end

  def kagawa
  end

  def kagawa1
  end

  def ehime
  end

  def ehime1
  end

  def kouchi
  end

  def kouchi1
  end

  def fukuoka
    @spots = Spot.where(prefecture: "福岡").all.reverse_order
    @q = @spots.ransack(params[:q])
  end

  def fukuoka1
    @sceness = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]

    @spots = Spot.where(prefecture: "福岡").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ショッピング", "癒し", "夜景", "テーマパーク", "美術館", "フォトジェニック", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

  def saga
  end

  def saga1
  end

  def nagasaki
  end

  def nagasaki1
  end

  def kumamoto
  end

  def kumamoto1
  end

  def oita
  end

  def oita1
  end

  def miyazaki
  end

  def miyazaki1
  end

  def kagoshima
  end

  def kagoshima1
  end

  def okinawa
  end

  def okinawa1
  end

  def oversea
  end

  def oversea1
  end

  private

def post_params
  params.require(:sample_form).permit(
    scenes: []
  )
end


end
