class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    band = Band.new(band_params)
    if band.valid?
      band.save
      redirect_to band_url(band.id)
    else
      render :new
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    # @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def update
    band = Band.find_by(id: params[:id]) # coming from url
    if band.update_attributes(band_params)  # tries to update, takes in band params arg
      redirect_to band_url(band.id)
    else
      render :edit
    end
  end


  def destroy
    band = Band.find_by(id: params[:id])
    band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
