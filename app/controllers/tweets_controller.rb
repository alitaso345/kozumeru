class TweetsController < ApplicationController
  def index
    maid = Maid.find(params[:maid_id])
    @tweets = maid.tweets if maid.twitter_account
  end
end
