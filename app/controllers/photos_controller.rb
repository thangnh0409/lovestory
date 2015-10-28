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
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def destroy
  end

private
  def photo_params
    params.require(:photo).permit(:name, :attachment)
  end
end
