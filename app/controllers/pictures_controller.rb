class PicturesController < ApplicationController
  def index
    if params[:maid_id]
      maid = Maid.find(params[:maid_id])
      @pictures = maid.pictures.where(kind: kind_params).page(params[:page]).per(10)
    else
      @pictures = Picture.where(kind: kind_params).page(params[:page]).per(10)
    end
  end

  private
  def kind_params
    case params[:kind]
      when "serve"
        0
      when "maid"
        1
      when "other"
        2
      else
        [nil, 0, 1, 2]
    end
  end
end
