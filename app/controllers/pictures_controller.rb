class PicturesController < ApplicationController
  def index
    if params[:maid_id]
      maid = Maid.find(params[:maid_id])
      @pictures = maid.pictures(kind_params).page(params[:page]).per(10)
    else
      @pictures = Picture.where(kind_params).page(params[:page]).per(10)
    end
  end

  private
  def kind_params
    if params[:kind]
      {kind: Picture.kinds[params[:kind].to_sym]}
    else
      {kind: [nil] + Picture.kinds.values}
    end
  end
end
