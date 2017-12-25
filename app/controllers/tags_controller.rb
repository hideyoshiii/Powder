class TagsController < ApplicationController
  
  def search
    @tags = ActsAsTaggableOn::Tag.most_used(30)
    @tags = Spot.all_tags.most_used(50)
    @spots1 = Spot.tagged_with("散歩").limit(7)
    @spots2 = Spot.tagged_with("BAR").limit(7)
  end

  def index

    if params[:prefecture].nil?
      @spots = params[:tag].present? ? Spot.tagged_with(params[:tag]) : Spot.all
      @tag = params[:tag]
    else
      @spots = params[:tag].present? ? Spot.tagged_with(params[:tag]) : Spot.all
      @spots = @spots.where(prefecture: params[:prefecture])
      @tag = params[:tag]
    end
  end

end
