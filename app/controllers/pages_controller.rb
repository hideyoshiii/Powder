class PagesController < ApplicationController

  def index
  end

  def prefecture
  end


  def hokkaido
  	@spots = Spot.where(prefecture: "東京").all.reverse_order
  	@q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
  end

  def hokkaido1
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

  def aomori
    @spots = Spot.where(prefecture: "青森").all.reverse_order
    @q = @spots.ransack(params[:q])
    @result = @q.result(distinct: true)
    @arrlistings = @result.to_a
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
  end

  def iwate1
  end

  def miyagi
  end

  def miyagi1
  end

  def akita
  end

  def akita1
  end

  def yamagata
  end

  def yamagata1
  end

  def fukushima
  end

  def fukushima1
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
  end

  def tokyo1
  end

  def kanagawa
  end

  def kanagawa1
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
  end

  def kyoto1
  end

  def osaka
  end

  def osaka1
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
  end

  def fukuoka1
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
