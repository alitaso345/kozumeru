class MaidsController < ApplicationController
  def index
    @maids = Maid.all
  end

  def show
    options = {}
    @maid = Maid.find(params[:id])
    @tweets = @maid.tweets.limit(50)
    @pictures = @maid.pictures(options).limit(10)
  end
end
