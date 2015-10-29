class AlbumsController < ApplicationController
  def index
    @albums = current_user.get_albums
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      flash[:info] = "Create ablum success!"
      redirect_to @album
    else
      render 'new'
    end
  end

  def show
    @album = Album.where(id: params[:id]).first();
    @photos = @album.get_photos
    @photo = @album.photos.build
  end

private
  def album_params
    params.require(:album).permit(:name, :description, :thumbnail)
  end
end
