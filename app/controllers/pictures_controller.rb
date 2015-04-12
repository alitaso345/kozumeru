class PicturesController < ApplicationController
  def index
    maid = Maid.find(params[:maid_id])
    @pictures = maid.pictures
  end
end
