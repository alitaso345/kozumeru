class PicturesController < ApplicationController
  def index
    if params[:maid_id]
      maid = Maid.find(params[:maid_id])
      if params[:kind]
        @pictures = maid.pictures.where(kind: params[:kind]).page(params[:page]).per(10)
      else
        @pictures = maid.pictures.page(params[:page]).per(10)
      end
    else
      if params[:kind]
        @pictures = Picture.where(kind: params[:kind]).page(params[:page]).per(10)
      else
        @pictures = Picture.all.page(params[:page]).per(10)
      end
    end
  end
end
