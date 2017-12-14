class ScenegingsController < ApplicationController
  
  def search
    
  end

  def index
    @arrlistings = Article.all.reverse_order

    if params[:sample_form].nil?
      @scenes = ["クリスマス", "記念日・誕生日", "サプライズ", "初デート", "お家デート", "アウトドア", "雨の日", "ドライブ", "ショッピング", "癒し", "夜景", "イルミネーション", "テーマパーク", "美術館", "フォトジェニック", "ホテル・旅館", "朝食", "ランチ", "ディナー", "カフェ", "バー", "居酒屋", "スイーツ", "食べ歩き", "春", "夏", "秋", "冬"]
    else
      @scenes = params[:sample_form][:scenes].to_a.reject(&:blank?) unless params[:sample_form].nil?
    end
  end

end
