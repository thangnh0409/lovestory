class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:info] = "Create ablum success!"
      redirect_to @album
    else
      render 'new'
    end
  end

  def show
    @album = Album.where(id: params[:id]).first();
    @photo = Photo.new
  end

private
  def album_params
    params.require(:album).permit(:name, :description)
  end
end
