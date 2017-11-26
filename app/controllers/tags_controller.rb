class TagsController < ApplicationController
  
  def search
    @tags = ActsAsTaggableOn::Tag.most_used(30)
  end

  def index
    @spots = params[:tag].present? ? Spot.tagged_with(params[:tag]) : Spot.all
    @tag = params[:tag]
  end

end
