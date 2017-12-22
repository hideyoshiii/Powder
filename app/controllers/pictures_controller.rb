class PicturesController < ApplicationController
    def create
        @picture = Picture.new(picture_params)
        if @picture.save
            redirect_to user_path(current_user)
        else
            redirect_to root_path
        end
    end

    def destroy
        @picture = Picture.find(params[:id])
        if @picture.destroy
            redirect_to user_path(current_user)
        else
            redirect_to root_path
        end
    end


    private
    def picture_params
        params.require(:picture).permit(:image,:spot_id,:user_id)
    end
end



