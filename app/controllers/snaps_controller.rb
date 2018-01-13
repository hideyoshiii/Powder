class SnapsController < ApplicationController
    def create
        @snap = Snap.new(snap_params)
        if @snap.save
            render json: { message: "success", snapId: @snap.id }, status: 200
        else
            render json: { error: @snap.errors.full_messages.join(", ") }, status: 400
        end
    end

    def destroy
        @snap = Snap.find(params[:id])
        if @snap.destroy
            render json: { message: "file deleted from server" }
        else
            render json: { message: @snap.errors.full_messages.join(", ") }
        end
    end

    def list
        article = Article.find(params[:article_id])

        snaps = []
        Snap.where(article_id: article.id).each do |snap|
            new_snap = {
                id: snap.id,
                name: snap.image_file_name,
                size: snap.image_file_size,
                src: snap.image(:thumb)
            }
            snaps.push(new_snap)
        end
        render json: { images: snaps }
    end


    private
    def snap_params
        params.require(:snap).permit(:image,:article_id,:user_id)
    end
end



