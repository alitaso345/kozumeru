class MaidsController < ApplicationController
  def index
    @maids = Maid.all
  end

  def show
    @maid = Maid.find(params[:id])
    @tweets = @maid.tweets.limit(50)
    @pictures = @maid.pictures.take(10)
  end
end
