class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create, :index]
  helper_method :sort_column, :sort_direction
  add_flash_types :error

  # GET /albums
  # GET /albums.json
  def index
    if params[:search]
      @albums = Album.search(params[:search]).order("title ASC")
    else
      @albums = Album.order(sort_column + " " + sort_direction)
    end
  end
  
  def myalbums
    @albums = current_user.albums.order(sort_column + " " + sort_direction)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    if current_user == @album.user
      @album.destroy
      respond_to do |format|
        format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {redirect_to albums_url, error: 'Unable to remove album: only the original creator can remove an album.'}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :artist, :description)
    end
    
    def sort_column
        params[:sort] || "title"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
end