class PicturesController < ApplicationController
  def index
    if params[:maid_id]
      maid = Maid.find(params[:maid_id])
      @pictures = maid.pictures
    else
      @pictures = Picture.where(kind: params[:kind]).page(params[:page]).per(10)
    end
  end
end
