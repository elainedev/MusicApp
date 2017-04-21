class AlbumsController < ApplicationController
  def new
    @band = Band.find_by(id: params[:band_id])
    render :new
  end

  def create
    album = Album.new(album_params)
    if album.valid?
      album.save
      redirect_to album_url(album.id)
    else
      redirect_to new_band_album_url(album.band_id)
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    album = Album.find_by(id: params[:id])

    if album.update_attributes(album_params)
      redirect_to album_url(album.id)
    else
      redirect_to edit_album_url(album.id)
    end
  end

  def show
    @album = Album.find_by(id: params[:id]) #gets info from url e.g. albums/1
    render :show
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy
    redirect_to bands_url
  end

private
def album_params
  params.require(:album).permit(:band_id, :album_type, :title)
end

end
