class TimelinesController < ApplicationController

	def index
	    @timelines = Timeline.order('id DESC')
	end

end



