class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash.now[:notice] = "Uploaded file successful!"
      redirect_to :back
    else
      flash[:danger] = @photo.errors.first[1]
      redirect_to album_path(id: @photo.album_id)
    end
  end

  def destroy
  end

private
  def photo_params
    Rails.logger.debug "Params #{params}"
    params.require(:photo).permit(:name, :attachment, :album_id)

  end
end
