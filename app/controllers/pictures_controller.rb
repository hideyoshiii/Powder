class PicturesController < ApplicationController
    def create
        @picture = Picture.new(picture_params)
        if @picture.save
            render json: { message: "success", pictureId: @picture.id }, status: 200
        else
            render json: { error: @picture.errors.full_messages.join(", ") }, status: 400
        end
    end

    def edit
    @picture = Picture.find(params[:id])
    if !(current_user == @picture.user)
      redirect_to root_path
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to user_path(current_user)
    end
  end

    def destroy
        @picture = Picture.find(params[:id])
        if @picture.destroy
            render json: { message: "file deleted from server" }
        else
            render json: { message: @picture.errors.full_messages.join(", ") }
        end
    end

    def destroy2
        @picture = Picture.find(params[:id])
        if @picture.destroy
            redirect_to user_path(current_user)
        else
            redirect_back(fallback_location: root_path) 
        end
  end

    def list
        spot = Spot.find(params[:spot_id])

        pictures = []
        Picture.where(spot_id: spot.id).each do |picture|
            new_picture = {
                id: picture.id,
                name: picture.image_file_name,
                size: picture.image_file_size,
                src: picture.image(:thumb)
            }
            pictures.push(new_picture)
        end
        render json: { images: pictures }
    end


    private
    def picture_params
        params.require(:picture).permit(:image,:spot_id,:user_id,:quote,:url)
    end
end



