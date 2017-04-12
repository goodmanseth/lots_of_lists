class ReviewsController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @review = @album.reviews.create(review_params)
    redirect_to album_path(@album)
  end
 
  def destroy
    @album = Album.find(params[:album_id])
    @review = @album.reviews.find(params[:id])
    @review.destroy
    redirect_to album_path(@album)
  end
    
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:reviewer, :body)
    end 
end
